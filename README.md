# Demo singularity container with SPM12 and Freeview

SPM12-based pipelines require a little extra work to get them compiled and working in a
container. Freesurfer's Freeview is also included here, as it's very handy for creating
the PDF QA report.

Freesurfer requires a license to run:
https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall#License
Best practice is to store your license file on the host that will run the container, and
bind it to the container at runtime - NOT to include your own license file in the 
container itself.

 