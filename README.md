# WHAT IS BASH?

bash is just like any other program installed on our computer, but while other programs are meant to do a specific task, bash is made to take commands from user and proform that task. it does not have any 1 fixed task.

to be able to talk to bash we need a language which we both can interpret and that language is SHELL which helps us to give commands to bash.

there are various shell programs like csh,zsh,bash,ksh,dash etc., even though all these shells are almost similar we have to know what shell we are using to avoid any syntax or POSIX error.

when we bash a command and its start working on it, we cannot access bash while its doing the work, once the task is done, it will again wait for the new instructions.

---
# FILE DESCRIPTOR 
- a file fescriptor is a number that uniquely identifies an opoen file or input/output stream ina linux/unix system. it is used to manage input, output, and errors for processes.

## standard input (0)
- file descriptor 0 is also called standard input
- this is where most processes receive theri input from
- normally our keyboard acts as a FD0 for our terminal, a source of input

## standard output (1)
- file descriptor 1 is also called standard output
- this is where most processes sends out their output to
- normally our monitor acts as a standard output device to show output from processes

## standard error (2)
- file descriptor 2 is also called standard error
- this is where most processes send their error and informational message 
- by default our monitor receives standard error just like standard output  

by default a process isn't limited to only these three file descriptors, it can create new ones with their own number and connect them to other files, devices or propcesses.

if any program wants to send its output to another program as its input, it will instruct the kernal to connect its standard output to the other program's standard input.

---

# THE PATH TO A PROGRAM
- on a standard unix system, there are few standardized locations for programs to go.
- some can be installed in `/bin` or `/usr/bin` or `/sbin` and so on
- since it will be hard to remember installation path of each program `PATH` env comes to rescue.
- `PATH` variable contains a set of directories that should be searched for programs  
- we can simply add any other path by adding another `:/my/path` in `PATH` env via bashrc

lets say we are installed a program at /sbin/test, if our PATH is set to `/bin:/sbin:/usr/bin:/usr/sbin` then bash will start it by `/bin/test` which doesn't exist and fail, then it will seach `/sbin/test/` and sucessfully execute it.

we can use `type test` to find from exactly where bash is running this program.

# **task 1** - create a script in your home directory, add it to your PATH and then run the script as an ordinary command.

---

# ARGUMENTS
normally in bash we have one liner commands to perform certain tasks like cp, mv, rm etc, but they are still not sufficient like cp what, what file do u want to copy or rm what , what file you want to remove these are considerd as arguments. 

- `cp test1.txt test2.txt` to bash blank space is a syntax which tells to break the previour apart from the next thing like test1.txt and text2.txt are two different thing and not one literal sentence.

- but if we want to have space in our sentence without bash taking it as a seperator we can either use quotes `"" or ''` or escape `\`

```bash
touch hello world -> this will create two files hello and world
touch 'hello world' -> this will create 1 file named `hello world`
touch "hello world" -> this will create 1 file named `hello world`
touch hello\ world -> this will create 1 file named `hello world`
```
while quotation and escape both method are valid syntax, `\` is a bit tidious compared to "" when there are a lot of spaces. 

but whats the difference between "" and ''

```bash
echo "$USER" -> will output luffy
echo '$USER' -> will output $USER
```
while both '' and "" can be used to quote a line, "" allows us to use other bash syntax while '' will process it like a normal string.

---

# REDIRECTION
remember file descriptor 0,1 and 2. while our keyboard and display attaches to 0,1 and 2 by default, we can actually manipute the standard input,output or error for processes to use something else as their standard input, output or error. this process is called REDIRECTION.


```bash
ls -> by default its output will be redirected to our display

it can be manipulated by `>`
ls > test.txt -> this will redirect the output of ls from our display to this file.
```
we wont see any output on screen but it will be stored in the `test.txt` file

**standard output is redirected through >**

```bash
ls bob.txt -> since this file doesnt exist, it will throw an error on screen
ls bob.txt > /dev/null -> will still see error since > only handles output and not error

ls bob.txt 2> /dev/null -> will redirect error to /dev/null and nothing will be printed on screen
```
**standard error is redirected through 2>**

```bash
ls . bob.txt -> this will show content of current directory and show error for bob.txt not being present 

ls . bob.txt > /dev/null -> content of current directory will be sent to null and error on our screen

ls . bob.txt > /dev/null 2>&1 
this is saying redirect output to /dev/null but also redirect standard error "2>" into "&" standard output "1" and here standard output is /dev/null so ultimately both will be redired into /dev/null and we wont see anything on our screen
```
**it is important that we define the standard output first and then 2>&1 so the standard error would redirect it to standard output which is already defined**

**if we do `ls . bob.txt 2>&1 > /dev/null` since here we are first defining where to redirect our error which is redirect it to standard output but we havent define it yet so our standard output is still our display so it will redirect it to our display and then our output is getting defined so will correctly redirect the standard output**

```bash
cat hello.txt > abc -> this will redirect the content of hello.txt to abc
cat hello2.txt > abc -> this will again overwrite the previous content with new content of hello2.txt

what if we want content of both files???

cat hello2.txt >> abc -> instead of overwriting it will append the new data
```

**>> append the output instead of overwriting like >**

---

# VARIABLES 
##### there are two places where variables are stored. one is shell variable and other is environment variable

- **shell variables** is a bash parameter that has a name. we use variables to store a value and later modify or read that value back for re-use.
- they are basically local variables whose scope is only the current shell session and exist only untill the shell session ends.

```bash
name=luffy
echo $name -> will output luffy
**no whitespaces pleases** bash does not permit this like other languages
```
- **Environment Variables** unlike shell variables environment variables exist at the process level
- they are basically global varibales which is available in current shell and all the child processes like subshells, scripts or programs and these also exist as long as the shell session exists

- if we want persistent variables then we need to export them in our bashrc or zshrc file located at `~/home/$USER/.bashrc`

- **array** allows us to store multiple values in a single varibale.
- there are two types of arrays in bash **indexed array** numerically indexed, starting from '0' and **associative array** which store key value pair like dictonaries

```bash
fruits=("apple" "banana" "mango")
echo ${fruits[1]} -> apple
echo ${fruits[1,3]} -> apple banana mango
echo ${fruits[@]} -> apple banana mango
echo ${#fruits[@]} -> length of array (3)
```
# TEST and CONDITIONALS
## IF
- single line `if [ confitions ] ; then echo "my condition worked"; fi`

- multi-line
```bash
if [[ condition ]]
then
    echo "my condtition worked"
fi
```

```bash
num=10
if [[ $num -gt 0 ]]; then
    echo "$num is greater than 0"
fi

if [[ -f "myfile.txt" ]]; then
    echo "file exist"
else 
    echo "file does not exist"
fi

# -f checks if a file exist

grade = 85
if [[ $grade -ge 90 ]]; then
    echo "A Grade"
elif [[ $grade -ge 80 ]]; then
    echo "B Grade"
elif [[ $grade -ge 70 ]]; then 
    echo "C Grade"
else 
    echo "fail"
fi
```

# COMMON CONDITIONS
- -eq means equals
- -ne means not equal
- -gt means greater than
- -lt means less than
- -ge means greater or equal
- -le means less or equal 
- -z means string is empty
- -n means sting is not empty
- -f means file exists
- d means directory exists
- && means AND operator
- || means OR operator

```bash
age=25
if [[ $age -gt 18 ]] && [[ $age -lt 30 ]]; then
    echo "you are a young adult"
fi
```

# FOR LOOP
```bash
for item in list_of_items
do
    echo "processing: $item"
done
```
- item -> a variable name we choose, could be i, file, etc..
- list_of_items -> what to loop through (number, files, word)
- do and done -> marks the start and end of the loop

```bash
fruits=("apple" "banana" "mango")
for items in "${fruits[@]}";
do
    echo "this is $items"
done
```

# WHILE LOOP
- run untill a condition is met
```bash
while [[ ! -d img ]]
do 
    echo "it exist"
    sleep 0.5
done
```

