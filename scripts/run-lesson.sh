#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: ./scripts/run-lesson.sh 01|02|03|04|05|06 [program arguments...]"
  exit 2
fi

lesson="$1"
shift

case "$lesson" in
  01) lesson_dir="01-first-program"; main_class="org.ftc.training.lesson01.RobotStatus" ;;
  02) lesson_dir="02-variables-and-math"; main_class="org.ftc.training.lesson02.WheelCalculator" ;;
  03) lesson_dir="03-decisions-and-deadbands"; main_class="org.ftc.training.lesson03.JoystickControl" ;;
  04) lesson_dir="04-loops-and-autonomous"; main_class="org.ftc.training.lesson04.AutoSequence" ;;
  05) lesson_dir="05-methods-classes-and-tests"; main_class="org.ftc.training.lesson05.DriveMathTest" ;;
  06) lesson_dir="06-virtual-intake-project"; main_class="org.ftc.training.lesson06.VirtualIntakeControllerTest" ;;
  *)
    echo "Unknown lesson '$lesson'. Choose 01 through 06."
    exit 2
    ;;
esac

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_dir/lessons/$lesson_dir/src"
build_dir="$repo_dir/build/lesson-$lesson"

mkdir -p "$build_dir"
find "$source_dir" -name '*.java' -print0 | xargs -0 javac --release 8 -d "$build_dir"
java -cp "$build_dir" "$main_class" "$@"
