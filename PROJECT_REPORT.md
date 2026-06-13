# Short Project Report

## Project Title

Smart Linux Admin Dashboard

## Project Option

Option 2: Terminal-Based Linux Admin Dashboard

## Purpose

The purpose of this project is to demonstrate practical UNIX/Linux skills using one complete Bash terminal application. The dashboard uses Linux commands, files, directories, permissions, users/groups, pipes, redirection, text-processing tools, backups, and report generation.

## How The Project Works

The main file is `dashboard.sh`. The script shows a menu inside the terminal and keeps running until the user chooses Exit. Each menu option calls a Bash function.

The script creates its working environment on the Ubuntu VM inside:

```bash
$HOME/admin_dashboard
```

This keeps generated files separate from the submitted source code.

## Implemented Features

1. Show System Information

Displays hostname, current user, date, uptime, kernel information, disk usage, and memory usage.

2. User and Groups Information

Displays the current user, UID, groups, users from `/etc/passwd`, and members of a selected group from `/etc/group`.

3. File and Directory Manager

Allows the user to create directories, create files, list files, copy files, rename files/directories, and safely remove files inside the workspace.

4. Permission Audit

Shows file permissions, detects files writable by others, detects executable files, checks unsafe directories, and prints a summary.

5. Text / Log File Analyzer

Analyzes text files by counting lines/words, searching keywords, showing unique sorted lines, sorting content, extracting a column, converting to uppercase, and converting to lowercase.

6. Backup Manager

Creates compressed `.tar.gz` backups of the workspace and stores backup history.

7. Generate Full Report

Generates a report in `$HOME/admin_dashboard/reports`. The report includes system information, user/group summary, permission audit summary, workspace contents, backup history, and recent actions.

## Bash Concepts Used

- Variables
- Functions
- `while` loops
- `case` statements
- `if` conditions
- `read` input
- Redirection using `>` and `>>`
- Pipes using `|`
- Command substitution using `$(...)`

## Conclusion

This project is a practical Linux administration dashboard built with Bash. It focuses on commands and skills used in UNIX/Linux labs rather than advanced programming frameworks.

## Team Contribution

- Student 1:Mohammad Mohammad id: 202210664 
- Student 2: Ahmed Amarneh    id: 202111634
