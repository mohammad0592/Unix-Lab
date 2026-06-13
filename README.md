# Smart Linux Admin Dashboard

UNIX/Linux Lab final project - Option 2: Terminal-Based Linux Admin Dashboard.

## Project Description

This project is a Bash script that runs as an interactive terminal menu. It performs simple Linux administration tasks using commands studied in UNIX/Linux lab, such as file operations, permissions, users/groups, pipes, redirection, text processing, backups, and reports.

The project folder is intentionally simple. When the script runs on the Ubuntu VM, it automatically creates its working folders inside:

```bash
$HOME/admin_dashboard
```

## Deliverable Files

```text
dashboard.sh
README.md
PROJECT_REPORT.md
COMMANDS_EXPLAINED.md
```

## How To Run On Ubuntu

```bash
chmod +x dashboard.sh
./dashboard.sh
```

The script creates these folders automatically on the VM:

```text
$HOME/admin_dashboard/workspace
$HOME/admin_dashboard/backups
$HOME/admin_dashboard/reports
```

## Main Menu

```text
1. Show System Information
2. User and Groups Information
3. File and Directory Manager
4. Permission Audit
5. Text / Log File Analyzer
6. Backup Manager
7. Generate Full Report
8. Exit
```

## Requirements Covered

| Requirement | How It Is Covered |
| --- | --- |
| Main Bash script | `dashboard.sh` |
| At least 6 options | 8 menu options |
| Loop | `while true` in main menu and submenus |
| Conditions | `if`, `[ ]`, and `case` |
| Input | `read -p` |
| Functions | More than 3 functions |
| Redirection | `>`, `>>`, and `<` |
| Pipes | `cut ... \| sort`, `find ... \| wc -l`, `sort file \| uniq` |
| Linux commands | More than 8 commands are used |
| Text processing | `grep`, `cut`, `sort`, `uniq`, `awk`, `tr`, `wc` |
| Report | Option 7 generates a report file |
| Evidence | real VM screenshots |

## Suggested Demo Steps

1. Run the dashboard.
2. Choose option 1 and show system information.
3. Choose option 3 and create a file in the workspace.
4. Choose option 4 and show the permission audit.
5. Choose option 5 and analyze .
6. Choose option 6 and create a backup.
7. Choose option 7 and generate a full report.
8. Take screenshots or copy terminal output for evidence.

## Team Contribution

- Student 1:Mohammad Mohammad id: 202210664 
- Student 2: Ahmed Amarneh    id: 202111634

## Links

- GitHub repository: https://github.com/mohammad0592/Unix-Lab

