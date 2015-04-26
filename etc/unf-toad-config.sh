#Toad configuration file
#Copyright 2014, The Toad Project
#credits by Mathieu Desrosiers
#to be sourced by toad users, typically in .bash_profile or equivalent

#define TOAD directory
TOADDIR=$( cd "$( dirname "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" )" && pwd )

case "$HOSTNAME" in
    stark)
        export TOADSERVER=stark
        APPDIR=/usr/local
        export SGEQUEUE='toad.q'
    ;;
    magma)
        export TOADSERVER=magma
        APPDIR=/usr/local
        export PATH=/usr/local/python-toad/bin:$PATH
        export SGEQUEUE='toad.q'
    ;;
    *)
    if [ -z "${BQMAMMOUTH}" ];
        then
            APPDIR=/usr/local
            echo "Warning, unknown server $HOSTNAME, will guess environment!"

        else
            export TOADSERVER=mammouth
            APPDIR=/home/desrosie/local
            export LD_LIBRARY_PATH=$APPDIR/osmesa/lib:$APPDIR/lib:$APPDIR/vtk/lib:$APPDIR/python-2.7/lib:$LD_LIBRARY_PATH
            export PATH=$APPDIR/python-2.7/bin:$PATH
            export SGEQUEUE='qwork4'
    fi
    ;;
esac


#disable KMP_AFFINITY
export KMP_AFFINITY=none

#Freesurfer configuration
export FREESURFER_HOME=$APPDIR/freesurfer
export FSFAST_HOME=$FREESURFER_HOME/fsfast
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$FREESURFER_HOME/lib
export PERL5LIB=$FREESURFER_HOME/mni/lib/perl5/5.8.5:$PERL5LIB

# FSL Configuration
FSLDIR=$APPDIR/fsl
export FSLOUTPUTTYPE=NIFTI_GZ
PATH=${FSLDIR}/bin:${PATH}
. ${FSLDIR}/etc/fslconf/fsl.sh
export FSLDIR PATH

export PATH=$TOADDIR/bin:$APPDIR/matlab-8.0/bin:$APPDIR/mrtrix3/bin:$APPDIR/mrtrix3/scripts:$PATH
export PATH=$FREESURFER_HOME/mni/bin:$FREESURFER_HOME/bin:$FREESURFER_HOME/tktools:$PATH
#:/usr/local/c3d/bin:/usr/local/itksnap/bin:/usr/local/fibernavigator/bin:$PATH