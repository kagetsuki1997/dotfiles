{ pkgs
, withVirtualisationGUISupports
, ...
}:

{
  config = {
    home.packages =
      with pkgs; [
        # libguestfs-with-appliance
        libvirt
        # qemu

        firecracker
        firectl
      ]
      ++ (if withVirtualisationGUISupports then with pkgs; [ virt-viewer virt-manager ] else [ ]);
  };
}
