# Demo singularity container with SPM12 and Freeview

SPM12-based pipelines require a little extra work to get them compiled and working in a
container. Freesurfer's Freeview is also included here, as it's very handy for creating
the PDF QA report.

See https://github.com/baxpr/demo-singularity-matlab-fsl for a lot of detailed info about
putting Matlab code into singularity containers.

SPM requires jumping an extra hurdle at the compilation step - we use a modified version
of SPM's own compiler function `spm_make_standalone.m`, found at 
`matlab/spm_make_standalone_local.m`. This process captures a lot of dependencies that
could otherwise easily be left out of the executable, with the resulting symptom that it
compiles just fine but fails at run time with various cryptic error messages. In addition
to SPM12, everything in the `matlab/src` directory is included in the path at compile time.
If Matlab toolboxes are used, they will need to be added to the list of included toolboxes
in `matlab/spm_make_standalone_local.m`.

Freesurfer requires a license to run:
https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall#License
Best practice is to store your license file on the host that will run the container, and
bind it to the container at runtime - NOT to include your own license file in the 
container itself.
