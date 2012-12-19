#!/bin/bash

# purge-history, a script to remove certain files from Git revision history
# Copyright (C) 2012 Jaromir Hradilek

# This program is  free software:  you can redistribute it and/or modify it
# under  the terms  of the  GNU General Public License  as published by the
# Free Software Foundation, version 3 of the License.
#
# This program  is  distributed  in the hope  that it will  be useful,  but
# WITHOUT  ANY WARRANTY;  without  even the implied  warranty of MERCHANTA-
# BILITY  or  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the  GNU General Public License  along
# with this program. If not, see <http://www.gnu.org/licenses/>.

# General script information:
NAME=${0##*/}
VERSION='1.0.0'

# A function that displays an error message, and immediately terminates the
# script.
#
# Usage: display_error [<error_message> [<exit_status>]]
function display_error {
  # Retrieve function arguments and assign their default values:
  local error_message=${1:-'An unexpected error has occurred.'}
  local exit_status=${2:-1}

  # Write the error message to standard output:
  echo -e "$NAME: $error_message" >&2

  # Terminate the script with the selected exit status:
  exit $exit_status
}

# A function that displays a list of files with all their predecessors.
#
# Usage: find_predecessors [<file_name>...]
function find_predecessors {
  # Declare required variables:
  local file
  local result

  # Process given file names:
  for file in "$@"; do
    # Look up all predecessors of the given file and add them to the list:
    result+=$(git log --pretty=format: --name-only --follow -- "$file" | sort -u)
  done

  # Display the result:
  echo "$result" | sed -e '/^$/d'
}

# Process command line options:
while getopts ":hv" OPTION; do
  case $OPTION in
    h)
      # Display usage information:
      echo "Usage: $NAME [OPTION...]"
      echo
      echo "  -h              display this help and exit"
      echo "  -v              display version information and exit"

      # Terminate the script:
      exit 0
      ;;
    v)
      # Display version information:
      echo "$NAME $VERSION"

      # Terminate the script:
      exit 0
      ;;
    *)
      # Report an error and terminate the script:
      display_error "Invalid option: $OPTARG" 22
      ;;
  esac
done

# Shift the positional parameters:
shift $(($OPTIND - 1))

# Verify the number of command line arguments:
if test "$#" -eq 0; then
  # Report an error and terminate the script:
  display_error "Invalid number of arguments." 22
fi

# Terminate the script:
exit 0
