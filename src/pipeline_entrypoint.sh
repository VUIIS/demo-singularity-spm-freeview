#!/usr/bin/env bash
#
# Primary entrypoint for our pipeline. This just parses the command line 
# arguments, exporting them in environment variables for easy access
# by other shell scripts later. Then it calls the rest of the pipeline.
#
# Example usage:
# 
# pipeline_entrypoint.sh --img_niigz /path/to/image.nii.gz --parameter_val 42

# This statement at the top of every bash script is helpful for debugging
echo Running $(basename "${BASH_SOURCE}")

# Initialize defaults for any input parameters where that seems useful
export parameter_val=42
export label_info="UNKNOWN SCAN"
export out_dir=/OUTPUTS

# Parse input options
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        
        --img_niigz)
            # Our example code takes a single 3D nifti image as input. This
            # is expected to be the fully qualified path (relative to the 
            # container) and filename.
            export img_niigz="$2"; shift; shift ;;

        --mask_niigz)
            # Some kind of mask or segmentation matching the input image, used 
            # for the freeview example PDF page
            export mask_niigz="$2"; shift; shift ;;

        --parameter_val)
            # Also take a numeric value as input to demonstrate how to handle
            # the way these come through as strings to a matlab executable
            export parameter_val="$2"; shift; shift ;;

        --label_info)
            # Info from from XNAT that we will use to label the QA PDF
            export label_info="$2"; shift; shift ;;

        --out_dir)
            # Where outputs will be stored. Also the working directory
            export out_dir="$2"; shift; shift ;;

        *)
            echo "Input ${1} not recognized"
            shift ;;

    esac
done


# Now that we have all the inputs stored in environment variables, call the
# main pipeline. We run it in xvfb so that we have a virtual display available.
xvfb-run -n $(($$ + 99)) -s '-screen 0 1600x1200x24 -ac +extension GLX' \
    bash pipeline_main.sh
