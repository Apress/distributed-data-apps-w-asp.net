----------------------------------------
Notes for sample files
----------------------------------------

Contents:
* Installing the Sample Files
* The Mobile Internet Toolkit
* Adding a Virtual Root
* Creating the Database
* Database Connection Strings
* Recompilation of the DLLs
* Known Issues
* Running on ASP.NET versions 1.0 and 1.1


* Installing the Sample Files
-----------------------------
* Install the files into a subfolder of your Web site.
Unzip the files using the "Restore Folders" or "Restore
Directories" option of your zip file manager software to
recreate the correct folder tree within the sample files.
It doesn't matter what the subfolder is called.


* The Mobile Internet Toolkit
-----------------------------
By default these examples expect the server to have the Microsoft
Mobile Internet Toolkit (MIT) installed. If not an error will occur.
We recommend that you install the MIT first - see:
http://msdn.microsoft.com/vstudio/

If you do not have the MIT installed, edit the file named
web.config that is found in the virtual root folder of the samples
(the directories named 4923-csharp and 4923-vbasic). Completely
remove the section <system.web> from this file, leaving only the
<appSettings> section that defines the database connection string
for the Web Services examples. Note that some of the samples will
fail without the MIT, notably the client detection examples and
any pages that are designed for small-screen and mobile devices.

Note that the current version of the MIT stores ViewState data in
the current ASP.NET Session. If the mobile client you use does not
support cookies (and hence Sessions), you may get an error when you
run these examples. As a temporary solution, edit either the
web.config file in the root folder of the samples, or the machine.config
file in your Winnt\Microsoft.NET\Framework\[version]\CONFIG folder,
to specify cookie-less Session support:

<sessionState ... cookieless="true" ... />

For a permanent solution, you can copy the mobile version pages plus
the associated resources it uses (the components and user controls)
to a separate folder that is marked as a virtual applictaion and
create a web.config file ther that specifies cookie-less sessions.


* Adding a Virtual Root
-----------------------
In Internet Services Manager, select the folder where you installed
the sample files (the folder containing this readme.txt file).
Right-click, select Properties, and click the Create button in the
Application Settings section of the Directory page. This creates a
Virtual Application based on the samples root folder, which is
required for the samples to locate the bin directory we use. If you
install both the VB.NET and C# samples, you must add a virtual root
for both of the samples root folders.


* Creating the Database
-----------------------
You need to create the sample database in SQL Server (based on version
7.0) using the scripts provided in the "database" directory of the
samples.

If you did not install the Northwind sample database supplied with
SQL Server 7.0:

- Using Enterprise Manager create a new empty database named "Northwind"
- Open SQL Server Query Analyzer from the Tools menu
- Make sure you select "Northwind" from the drop-down DB list
- Open the file "make-tables.sql" and execute it
- Open the file "insert-data.sql" and execute it

Or if you already have the "Northwind" samples database installed:
- Open SQL Server Query Analyzer from the Tools menu
- Make sure you select "Northwind" from the drop-down DB list
- Open the file "make-stored-procs-only.sql" and execute it
- Give the user "anon" permissions to access all the tables
  or change the connection string to specify a different user


* Database Connection Strings
-----------------------------
Edit the web.config file located in the root folder of the samples,
which contains the database connection string. The two values you may
need to edit are:

<appSettings>
  <add key="NorthwindConnectString"
       value="provider=SQLOLEDB.1;data source=[your-server];
              initial catalog=Northwind;uid=anon;pwd=;" />
  <add key="NorthwindSqlClientConnectString"
       value="server=localhost;database=Northwind;uid=anon;pwd=;" />
</appSettings>

Replace [your-server] with the name of your database server. Change the
User ID and password if required. You may also need to change the value
"localhost" if your SQL Server is on a different machine from the one
that is running the samples (i.e. not on the Web server).


* Recompilation of the DLLs
---------------------------
The compiled DLLs in the "bin" folder(s) are .NET version-
dependent. If you receive the error "Cannot find System.Data or
one of its dependencies" (or a similar error message), you must
re-compile the DLLs using the source code and make.bat files provided,
with the compiler from the version of .NET that you are running.


* Known Issues
--------------
The various versions of the client application that updates the customer
orders data implement slightly different "business rules", which can
result in an error. The HTML 3.2 version allows you to delete the value
for the "Required Date" of an order in the Orders table, leaving it set
to NULL in the databasetable.

However, the XML-based versions for Internet Explorer 5.0 expect there
to be a value for this column in every row. This was done to keep the
code required to manipulate the diffgram as simple as possible. If you
delete the Required Date value for a row and then open that customer
in one of the IE5 versions of the application, the columns are not
correctly mapped to the controls in the page, and performing an update
will cause an error.


Running on ASP.NET version 1.0 and 1.1
--------------------------------------
Version 1.1 of ASP.NET includes a validation feature that checks all of
the values posted to the server for "dangerous content". It will reject
any values that are XML or HTML, and so will prevent some versions of the
application from working properly. To solve this, you must add the
the attribute ValidateRequest="False" to the Page directive in version
1.1. The sample files include this, but it means that the pages will fail
when run under version 1.0. This applies to the following page:

update-orders\ie5\reconcile-changes.aspx

If you are running under version 1.0, you must remove the ValidateRequest
attribute from the Page directive. The error message you see will indicate
this when running the pages from a browser located on the server.

----------------------------------------
----------------------------------------
