#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
workspace_repos="$(cd "$repo_root/.." && pwd)"
hardware_repo="$workspace_repos/ftc-hardware-lab"
sdk_samples="$hardware_repo/FtcRobotController/src/main/java/org/firstinspires/ftc/robotcontroller/external/samples"
output_dir="$repo_root/claude-project/generated"
output_file="$output_dir/FTC_STUDENT_TUTOR_KNOWLEDGE.txt"

curriculum_files=(
  "README.md"
  "GETTING_STARTED.md"
  "CURRICULUM.md"
  "PROGRAM_ROADMAP.md"
  "levels/01-java-foundations.md"
  "levels/02-hardware-lab.md"
  "levels/03-robot-systems-and-teleop.md"
  "levels/04-autonomous-motion.md"
  "levels/05-coordinated-autonomous.md"
  "docs/student-workflow.md"
  "docs/java-compatibility.md"
  "docs/macos-setup.md"
  "docs/windows-setup.md"
  "docs/vscode-setup.md"
  "docs/level-2-setup.md"
  "docs/control-hub-connection.md"
  "docs/github-and-git-setup.md"
  "docs/hardware-lab-contract.md"
  "docs/robot-code-architecture.md"
  "claude-project/EXTERNAL_RESOURCES.md"
)

while IFS= read -r path; do
  curriculum_files+=("${path#"$repo_root/"}")
done < <(find "$repo_root/lessons" -type f \( -name 'README.md' -o -name '*.java' \) | sort)

while IFS= read -r path; do
  curriculum_files+=("${path#"$repo_root/"}")
done < <(find "$repo_root/level-2" "$repo_root/level-3" "$repo_root/level-4" "$repo_root/level-5" -type f -name 'README.md' | sort)

sdk_files=(
  "readme.md"
  "sample_conventions.md"
  "BasicOpMode_Linear.java"
  "BasicOpMode_Iterative.java"
  "BasicOmniOpMode_Linear.java"
  "ConceptTelemetry.java"
  "ConceptGamepadEdgeDetection.java"
  "SensorTouch.java"
  "SensorColor.java"
  "RobotAutoDriveByEncoder_Linear.java"
  "RobotTeleopMecanumFieldRelativeDrive.java"
  "externalhardware/RobotHardware.java"
)

mkdir -p "$output_dir"

append_source() {
  local display_path="$1"
  local source_path="$2"

  if [[ ! -f "$source_path" ]]; then
    echo "Missing required source file: $source_path" >&2
    exit 1
  fi

  echo
  echo "======================================================================"
  echo "BEGIN SOURCE FILE: $display_path"
  echo "======================================================================"
  echo
  sed 's/[[:space:]]*$//' "$source_path"
  echo
  echo "END SOURCE FILE: $display_path"
}

{
  echo "FTC JAVA STUDENT TUTOR — CURRICULUM AND CURATED REFERENCES"
  echo
  echo "Curriculum revision: $(git -C "$repo_root" rev-parse --short HEAD 2>/dev/null || echo unknown)"
  echo "Pinned FTC SDK reference version: 11.2.1"
  echo "This bundle excludes instructor and mentor materials."

  for relative_path in "${curriculum_files[@]}"; do
    append_source "$relative_path" "$repo_root/$relative_path"
  done

  for relative_path in "${sdk_files[@]}"; do
    append_source "FTC-SDK-11.2.1/external/samples/$relative_path" "$sdk_samples/$relative_path"
  done
} > "$output_file"

echo "Built $output_file"
