>Note: After turning in my thesis, I noticed the order of operations is reversed for multiplication/division and addition/subtraction in `parseInfo.jison`. Use parenthesis to enforce correct order.

# Compiler
Haskell inspired toy-language that compiles and runs entirely in the browser. Does basic arithmetic/variable expressions. Implements lazy evaluation.

##Use

Currently hosted at [http://cs.okstate.edu/~shortjm/compiler](http://cs.okstate.edu/~shortjm/compiler). Follow the instructions on the page.

This project can be run from a web server or from a local file system.

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

