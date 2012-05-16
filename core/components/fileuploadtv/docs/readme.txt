FileUploadTV

--------------------------------------------------------------------------------

Description
---
FileUpload is an extra for ModX wich add a new TV into your manager. This TV allows to quickly upload a file from
your computer and then add a link above the field so your team can dowload it.

Install
---
If you don't have the package yet, you can download it on GitHub. Unzip it in a FileUploadTV folder, located at the root of your website. Package the extra by running the build.transport.php file in the _build directory. Once you've got the package install it via Package Manager (if you don't see it try to select "Search locally for packages" at the top of packages list.

How to use ?
---
Once the extra installed, create a new TV with an input type of fileUpload and set the properties below.

Now you can set a file for each page of your website !

Need more explanations ? Don't be shy ! Send a mail at iux@ackwa.fr

Parameters
---
**MediaSource :** When a media source is setted, the TV will use the basePath to upload files.
If MediaSource or its basePath is blank, files will be upload at assets/data/

**MaxSize : ** Set the maximum size (in Ko) you can upload. If it's blank, it use modx upload_maxsize.

**ForbiddenTypes :** MODx have a list of allowed files and FileUploadTV checks if the type is allowed,
but you can restrick some types besides it.

Improvements
---
We want this tool as close as possible of your needs. So if your have a suggestion, feel free to create an issue on GitHub or submit us your work (with pull requests on GitHub if it's possible). We also looking people to translate the extra and make it accessible for everyone.

Bug tracker
---
Have a bug? Please create an issue here on GitHub - https://github.com/ackwa/FileUploadTV!

--------------------------------------------------------------------------------

Authors
---
Kevin Pause, Gildas Noel

Thanks
---
We'd like to thanks Shaun McCormick for his help on modx forum and modx rtfm.

