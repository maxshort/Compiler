# Compiler
Subset of Haskell compiled in browser

Currently just does binary addition (e.g. 3 +3)

##Use

Currently hosted at [http://cs.okstate.edu/shortjm/compiler](http://cs.okstate.edu/shortjm/compiler). Follow the instructions on the page.

If you want to run this project on your own computer after building, you must serve it from a web server (don't just point your web browser to a file - must use http). This is due to `llvm.js` pulling its dependencies in via javascript requests. To do this from python 3 (assuming python is on your path), navigate to the `/build` directory of the project and then type `python -m http.server`.

##Building

###Required software:
1. [Node.js](https://nodejs.org/en/download/)  and Node Package Manager(NPM). NPM is installed automatically with node. Make sure that both Node.js and NPM are globally available on your machine.
2. Install the gulp build system globally using the command `npm install gulp -g`.
3. Install jison (node version of bison) globally using the command `npm install jison -g`.

###Build Process

####Build Option 1: Build locally only
1. At the command prompt, type `gulp build`.
2. Follow the use instructions above

####Build Option 2: Build locally, push to remote server using ssh
1. Create a file called `cred.json` in the project root like the following example:

        {
          "host":"<your host string here>",
          "port":"<your port here>",
          "username":"<your username here>",
          "password":"<your password here if no ssh key>",
          "privateKey":"<your ssh key here if no password>"
        }
2. run `gulp pushOnSuccess`

