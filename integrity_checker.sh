#!/bin/bash

BASELINE_DIR="./baselines"
REPORT_DIR="./reports"
mkdir -p "$BASELINE_DIR" "$REPORT_DIR"

function create_baseline() {
    read -p "Enter directory path to create baseline: " target_dir
    if [[ ! -d "$target_dir" ]]; then
        echo "Directory does not exist!"
        return
    fi

    timestamp=$(date +"%Y%m%d_%H%M%S")
    baseline_file="$BASELINE_DIR/baseline_$(basename "$target_dir")_$timestamp.txt"

    find "$target_dir" -type f -exec sha256sum {} \; | sort > "$baseline_file"
    echo "Baseline created at $baseline_file"
}

function check_integrity() {
    read -p "Enter path of baseline file: " baseline_file
    if [[ ! -f "$baseline_file" ]]; then
        echo "Baseline file does not exist!"
        return
    fi

    read -p "Enter directory to scan: " target_dir
    if [[ ! -d "$target_dir" ]]; then
        echo "Directory does not exist!"
        return
    fi

    current_scan=$(mktemp)
    find "$target_dir" -type f -exec sha256sum {} \; | sort > "$current_scan"

    report_file="$REPORT_DIR/report_$(date +"%Y%m%d_%H%M%S").txt"
    echo "=== Integrity Check Report ===" > "$report_file"
    diff "$baseline_file" "$current_scan" >> "$report_file"

    if [[ $? -eq 0 ]]; then
        echo "No changes detected."
    else
        echo "Changes detected. See report at: $report_file"
    fi

    rm "$current_scan"
}

function menu() {
    while true; do
        echo ""
        echo "====== File System Integrity Checker ======"
        echo "1. Create Baseline"
        echo "2. Check Integrity"
        echo "3. Exit"
        echo "=========================================="
        read -p "Choose an option [1-3]: " choice

        case $choice in
            1) create_baseline ;;
            2) check_integrity ;;
            3) echo "Exiting..."; break ;;
            *) echo "Invalid choice. Try again." ;;
        esac
    done
}

menu
