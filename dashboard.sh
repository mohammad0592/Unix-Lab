#!/bin/bash


PROJECT_DIR="$HOME/admin_dashboard"
WORKSPACE="$PROJECT_DIR/workspace"
BACKUP_DIR="$PROJECT_DIR/backups"
REPORTS_DIR="$PROJECT_DIR/reports"
mkdir -p "$WORKSPACE" "$BACKUP_DIR" "$REPORTS_DIR"


show_system_info() {
echo "===== System Information ====="
echo "Hostname : $(hostname)"
echo "User     : $(whoami)"
echo "Date     : $(date)"
echo "Uptime   : $(uptime -p)"
echo "Kernel   : $(uname -a)"
echo "--- Disk Usage ---"
df -h /
echo "--- Memory Usage ---"
free -h
}
users_info() {
echo "===== Users and Groups Information ====="
echo "Current user : $(whoami)"
echo "User ID (UID): $(id -u)"
echo "Your groups  : $(groups)"
echo
echo "--- System users (from /etc/passwd) ---"
cut -d: -f1 /etc/passwd | sort
echo
read -p "Enter a group name to inspect (or press Enter to skip): " grp
if [ -z "$grp" ]
then
echo "No group selected."
return
fi
if grep -q "^$grp:" /etc/group; then
echo "--- Members of group '$grp' ---"
members=$(grep "^$grp:" /etc/group | cut -d: -f4)
if [ -z "$members" ]; then
echo "(No extra members listed for this group.)"
else
echo "$members"
fi
else
echo "Group '$grp' does not exist."
fi
}
file_manager() {
while true; do
echo "===== File and Directory Manager ====="
echo "Working folder: $WORKSPACE"
echo "1. Create directory"
echo "2. Create file"
echo "3. List files"
echo "4. Copy file"
echo "5. Move / rename file"
echo "6. Remove file"
echo "7. Back to main menu"
echo "======================================"
read -p "Choose an option: " fchoice

case $fchoice in
1)
read -p "Enter new directory name: " dname
if [ -z "$dname" ]; then
echo "Name cannot be empty."
elif [ -d "$WORKSPACE/$dname" ]; then
echo "Directory already exists."
else
mkdir "$WORKSPACE/$dname"
echo "Directory '$dname' created."
fi
;;
2)
read -p "Enter new file name: " fname
if [ -z "$fname" ]; then
echo "Name cannot be empty."
elif [ -f "$WORKSPACE/$fname" ]; then
echo "File already exists."
else
touch "$WORKSPACE/$fname"
echo "File '$fname' created."
fi
;;
3)
echo "--- Contents of workspace ---"
ls -l "$WORKSPACE"
;;
4)
read -p "Enter source file name: " src
read -p "Enter new copy name: " dest
if [ ! -f "$WORKSPACE/$src" ]; then
echo "Source file not found."
else
cp "$WORKSPACE/$src" "$WORKSPACE/$dest"
echo "Copied '$src' to '$dest'."
fi
;;
5)
read -p "Enter current file name: " old
read -p "Enter new name: " new
if [ ! -f "$WORKSPACE/$old" ]; then
echo "File not found."
else
mv "$WORKSPACE/$old" "$WORKSPACE/$new"
echo "Renamed '$old' to '$new'."
fi
;;
6)
read -p "Enter file name to remove: " target
if [ ! -f "$WORKSPACE/$target" ]; then
echo "File not found."
else
rm -i "$WORKSPACE/$target"
echo "Done."
fi
;;
7)
break
;;
*)
echo "Invalid choice, please try again."
;;
esac
echo
done
}
permission_audit() {
    echo "===== Permission Audit ====="
    echo "Auditing folder: $WORKSPACE"
    echo

    # --- 1. Show all permissions ---
    echo "--- Current permissions (ls -l) ---"
    ls -l "$WORKSPACE"
    echo

    # --- 2. Files writable by others (risky) ---
    echo "--- Files writable by OTHERS (unsafe) ---"
    risky=$(find "$WORKSPACE" -type f -perm -o=w)
    if [ -z "$risky" ]; then
        echo "None found. Good!"
    else
        echo "$risky"
        echo "Recommendation: remove write access for others using:"
        echo "  chmod o-w filename"
    fi
    echo

    # --- 3. Executable files ---
    echo "--- Executable files ---"
    execs=$(find "$WORKSPACE" -type f -perm -u=x)
    if [ -z "$execs" ]; then
        echo "No executable files found."
    else
        echo "$execs"
        echo "Note: make sure only scripts that SHOULD run are executable."
    fi
 echo

    echo "--- Directories writable by OTHERS (unsafe) ---"
    riskydirs=$(find "$WORKSPACE" -type d -perm -o=w)
    if [ -z "$riskydirs" ]; then
        echo "None found. Good!"
    else
        echo "$riskydirs"
        echo "Recommendation:"
        echo "  chmod o-w directoryname"
    fi
    echo

    total_files=$(find "$WORKSPACE" -type f | wc -l)
    risky_count=$(find "$WORKSPACE" -type f -perm -o=w | wc -l)
    echo "--- Audit Summary ---"
    echo "Total files checked   : $total_files"
    echo "Files writable by others: $risky_count"
}
analyzer_text() {
read -p "Enter the file path to analyze" file
if [ ! -f "$file" ]
then
echo "File not found!"
fi
echo "lines : $(wc -l < "$file")"
echo "Words : $(wc -w < "$file")"
read -p "Enter a keyword to search: " word
echo "--- Matches for '$word' ---"
grep -n "$word" "$file"
echo "--- Unique sorted lines ---"
sort "$file" | uniq
}
backup_manager() {
while true
do
    echo "===== Backup Manager ====="
    echo "1. Create backup of workspace"
    echo "2. List existing backups"
    echo "3. Back to main menu"
    echo "=========================="
    read -p "Choose an option: " bchoice

    case $bchoice in

        1)  # --- Create backup ---
            # Timestamp makes every backup name unique
            stamp=$(date +%Y%m%d_%H%M%S)
            backup_file="$BACKUP_DIR/backup_$stamp.tar.gz"

            # Check there is something to back up
            file_count=$(find "$WORKSPACE" -type f | wc -l)
            if [ "$file_count" -eq 0 ]; then
                echo "Workspace is empty - nothing to back up."
                return
            fi

            tar -czf "$backup_file" -C "$PROJECT_DIR" workspace

            if [ -f "$backup_file" ]; then
                echo "Backup created successfully:"
                ls -lh "$backup_file"
                # Append to backup history log (>> = append)
                echo "$(date) | $backup_file | $file_count files" >> "$BACKUP_DIR/backup_history.log"
  else
                echo "Backup failed!"
            fi
            ;;

        2)  # --- List backups ---
            echo "--- Existing backups ---"
            ls -lh "$BACKUP_DIR"/*.tar.gz 2>/dev/null
            echo
            echo "--- Backup history ---"
            if [ -f "$BACKUP_DIR/backup_history.log" ]; then
                cat "$BACKUP_DIR/backup_history.log"
            else
                echo "No backups have been made yet."
            fi
            ;;

        3)  return ;;

        *)  echo "Invalid choice." ;;
    esac
done
}

generate_report() {
report="$REPORTS_DIR/report_$(date +%Y%m%d_%H%M%S).txt"
echo "System Report - $(date)" >  "$report"
echo "User: $(whoami)"         >> "$report"
echo "--- Disk ---"            >> "$report"
df -h /                        >> "$report"
echo "--- Memory ---"          >> "$report"
free -h                        >> "$report"
echo "Report saved to: $report"
}
while true
do
echo "==============================="
echo " Smart Linux Admin Dashboard"
echo "==============================="
echo "1. Show System Information"
echo "2. User and Groups Information"
echo "3. File and Directory Manager"
echo "4. Permission Audit"
echo "5. Text / Log File Analyzer"
echo "6. Backup Manager"
echo "7. Generate Full Report"
echo "8. Exit"
echo "=============================="
read -p "Choose an option: " choice

case $choice in
1) show_system_info ;;
2)users_info ;;
3)file_manager ;;
4)permission_audit ;;
5)analyzer_text ;;
6)backup_manager ;;
7)generate_report ;;
8)echo "Goodbye!"; break ;;
*)echo "Invalid choice, please try again." ;;
esac

echo
read -p "Press Enter to continue... " dummy

done