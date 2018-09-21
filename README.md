# fileserver
==============

Bash script to create a file server on Ubuntu 18.04

Create a File Server to backup or share files with other Linux users. 

Install
-------
```
$ git clone git@github.com:obe711/fileserver.git
$ bash install.sh
```

Logging Into the File Server
----------------------------

Linux — The Command Line
You can use a tool called smbclient to access Samba from the command line. This package is not included by default on most Linux distributions, so you will need to install it with your local package manager.

On Debian and Ubuntu servers install smbclient with the following command:
```
$ sudo apt-get update
$ sudo apt-get install smbclient
```
On Fedora systems, use the following:
```
$ sudo dnf update
$ sudo samba-client
```
And on CentOS:
```
$ sudo yum update
$ sudo yum install samba-client
```
smbclient uses the following format to access Samba shares:
```
$ smbclient //your_samba_hostname_or_server_ip/share -U username
```
You can use either your server's IP or the hostname you defined in /etc/samba/smb.conf to access the share. This example uses the hostname samba.example.com to access david's share on the Samba server you created in the previous steps:
```
$ smbclient //samba.example.com/david -U david
```
If david wants access to the common share (everyone), change the command to:
```
$ smbclient //samba.example.com/everyone -U david
```
After running the smbclient command, you will be prompted for the Samba password and logged into a command line interface reminiscent of the FTP text interface:
```
smb: \>
```
This interface is most useful for testing usernames and passwords and read-write access. For example, you can create a directory and list its contents as follows:
```
smb: \> mkdir test
smb: \> ls
```
You should see the following output:
```
Output
  .                                   D        0  Fri Feb  2 14:49:01 2018
  ..                                  D        0  Wed Jan 24 12:11:33 2018
  test                                D        0  Fri Feb  2 14:49:01 2018
```
Remove the directory by typing:
```
$ rmdir test
```


MacOS — The Command Line
------------------------
MacOS comes pre-installed with command line tools you can use to access a Samba share. Open the terminal with Launchpad by clicking on the Terminal icon.

This will open a command line terminal in your home directory. To mount the Samba share, you can create a new directory that will act as the mount point for the share. A mount point is the location where two file systems are joined: in this case, your local file system and the remote Samba file system.

Create a new directory called samba:
```
$ mkdir samba
```
Next, mount the Samba share under the new samba directory. This command has the form:
```
$ sudo mount_smbfs //username@your_samba_hostname_or_server_ip/share ./mount_point
```
Substituting the details from Example.com with user david looks like this:
```
$ sudo mount_smbfs //david@samba.example.com/david ./samba
```
The samba directory will now show the contents of the david share on the Example.com Samba server. Files and directories can be manipulated with the normal tools such as ls, rm, and mkdir; however, the samba directory will be owned by root after the share has been mounted. You will therefore need to use sudo to access the samba directory and its contents.

To unmount the Samba share, run the umount command from the same directory where you ran the mkdir command:
```
$ umount samba
```
The next section will look at accessing a Samba share using the desktop GUI application in macOS.

MacOS — Desktop
---------------
MacOS is also able to access Samba shares using the Finder application.

Take the following steps:
1. Open Finder and click Go in the menubar.
2. Click on Connect to Server from the list of options.
3. Use a smb:// format URL that includes your username, your hostname or server IP, and the name of your share: smb://username@your_samba_hostname_or_server_ip/share. In the example shown here, you will see the username david and the hostname samba.example.com.
4. Bookmark the Samba share by clicking on the button with a + symbol.
5. Click Connect
6. Select Registered User
7. Enter the username and password for the Samba share user.
8. Decide if you would like macOS to store the password.
9. Click Connect.

After you have successfully connected to the Samba share it will appear in Finder.

The next section will explore how to access Samba shares from Windows 10.

Windows 10 — The Command Line
-----------------------------
Mounting a Samba share from the Windows command line only requires a single command:
```
C:\> net use drive_letter \\your_samba_hostname_or_server_ip\share
```
Substitute the variables from user david's share and set the drive letter to X::
```
C:\> net use X: \\samba.example.com\david
```
When this command is entered you will be prompted for david's username and password. After entering these, you will receive an acknowledgment that the share was successfully mounted:
```
Output
Enter the user name for 'samba.example.com': david
Enter the password for samba.example.com:
The command completed successfully.
```
You will now be able to browse the Samba share in File Explorer and manipulate the files and directories as if they were local to your computer.

The next section will look at using Windows GUI tools to access a Samba share.

Windows 10 — Desktop
--------------------

Windows 10 also has the native ability to connect to a Samba share. The following steps will connect you to your Samba share and keep it as a bookmark using Windows File Explorer. Begin these steps by opening File Explorer:
1. Right click on This PC.
2. Click on Add a network location and then Next on the page that follows.
3. Click on Choose a custom network location.
4. Click Next
5. Enter the Windows style address of the Samba server and the share name. Windows uses the following form of a Samba URL: \\your_samba_hostname_or_server_ip\share\. In the example image the server name is samba.example.com and the share name is david: \\samba.example.com\david.
6. Click Next.
7. Enter the username and password for the user.
8. Decide whether or not you want Windows to remember the password.
9. Click OK.

File Explorer will now connect to the Samba share. Once the connection has successfully completed, a new location will be created under This PC in File Explorer:

You will now be able to use this folder to manage files and folders in the Samba share as if it were a local folder.
