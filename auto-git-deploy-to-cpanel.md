# Use cPanel to Host Your Git Repository and Deploy Automatically
Below are the variables for the examples.  Change these to suit your needs/preference.

The hostname is:  your.host.name
The SSH port is:  222
The cPanel account name is:  accountname
The local Git directory is called: localname
The remote Git repo will be stored in a directory called: www.git
shortcut  is what I will call the optional ssh shortcut.
~/Sites is your local development directory (so ~/Sites/localname will be the full path to your local Git.)
 

### Step 0: Create an SSH key on your local machine.
### Step 1: Add your SSH public key to the cPanel account.
In the “Security” section click on SSH Shell Access
Click “Manage SSH Keys”
Click “Import Key”
Copy and paste the key into the public key text box.  (Hint: on a Mac, use this command from the Terminal to copy your public key, in this example, it is called “id_rsa”.)  pbcopy < ~/.ssh/id_rsa.pub
Click “Import”
Go back to the Manage SSH Keys page and click “Manage Authorization”.
Click “Authorize”.
### Step 2: Set up the remote Git repository.
Log into the remote server via SSH…
```
ssh -p222 accountname@your.host.name
```
Hint:  I like to set up shortcuts in my SSH config file (~/.ssh/config).  For example, to make a shortcut named for the localname…

Host shortcut
HostName your.host.name
Port 222
User accountname

So then you can simply log in with: ssh shortcut

From the account root (above public_html), set up a directory (called www in this example) for your Git repo..
```
mkdir -p ~/www.git && cd $_
git init --bare
```
Add a command in the post-receive hook…
```
cat > hooks/post-receive << EOF
#!/bin/sh
GIT_WORK_TREE=/home/accountname/public_html git checkout -f
EOF
```
Change permissions on that same file…
```
chmod +x hooks/post-receive;
```
### Step 3: Add the remote Git repo.
Now, back on the local machine move to your local repository (or create one if need be)…
```
cd ~/Sites/localname
```
Add a remote Git repo that points to your server. (i will call mine www as above, but you can call it “production” or whatever you want it need not match the repo name)…
```
git remote add www ssh://accountname@your.host.name/home/accountname/www.git/
```
Or if you are using the SSH config hint from above, simply…
```
git remote add www ssh://shortcut/home/accountname/www.git/
```
Push to the server…
```
git push www +master:refs/heads/master
```
To update the site in the future, just use…
```
git push www
```
…Or any Git GUI will do for the pushing.
