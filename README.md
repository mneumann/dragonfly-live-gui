# dragonfly-live-gui
Scripts to build a DragonFly Live GUI image

## VirtualBox

You need to convert the raw image file into a file suitable for VirtualBox:

    VBoxManage convertfromraw --format VMDK live.img live.vmdk

Then, when mounting the root filesystem, it is trying to load it from the
USB disk <tt>ufs:da8s1a</tt>. Of course this does not exist. So type in
<tt>ufs:ad0s1a</tt> instead (or <tt>ufs:da0s1a</tt> if you are booting
from SATA).
  
  
