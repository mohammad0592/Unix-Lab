# Commands Explained

The project uses basic UNIX/Linux commands that are commonly studied in lab work.

| Command | Used For |
| --- | --- |
| `mkdir -p` | Creates project folders if they do not exist. |
| `touch` | Creates an empty log file or workspace file. |
| `hostname` | Shows the machine name. |
| `whoami` | Shows the current logged-in user. |
| `date` | Shows time/date and creates backup/report timestamps. |
| `uptime -p` | Shows how long the system has been running. |
| `uname -a` | Shows kernel/system information. |
| `df -h` | Shows disk usage in readable format. |
| `free -h` | Shows memory usage in readable format. |
| `id -u` | Shows the current user's UID. |
| `groups` | Shows groups for the current user. |
| `cut` | Extracts fields from `/etc/passwd` and `/etc/group`. |
| `sort` | Sorts users or text file lines. |
| `grep` | Searches for groups or keywords. |
| `ls -la` / `ls -l` | Lists files and permissions. |
| `cp` | Copies files. |
| `mv` | Moves or renames files/directories. |
| `rm -i` | Safely removes files with confirmation. |
| `find` | Searches files and checks permission patterns. |
| `chmod` | Recommended command for fixing unsafe permissions. |
| `wc` | Counts lines, words, and files. |
| `uniq` | Removes repeated adjacent lines after sorting. |
| `awk` | Extracts a selected text column. |
| `tr` | Converts text to uppercase or lowercase. |
| `tar -czf` | Creates compressed backup files. |
| `cat` | Displays backup history in the terminal/report. |
| `tail` | Shows recent action log lines. |

## Redirection Examples

```bash
echo "text" > file.txt
echo "more text" >> file.txt
tr 'a-z' 'A-Z' < file.txt
```

## Pipe Examples

```bash
cut -d: -f1 /etc/passwd | sort
find "$WORKSPACE" -type f | wc -l
sort "$file" | uniq
```

## Commands I Avoided

I avoided advanced or unnecessary tools such as databases, APIs, Docker, `jq`, Python scripts, and network commands because the project should look like a UNIX/Linux lab Bash project.
