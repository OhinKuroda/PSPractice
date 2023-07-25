#2 types of errors Terminating and Non-Terminating
#Terminating error - Internal shell discovers an issue and tells parent shell to stop the internal shell
#                ***Can Use trapping to stop termation signal from being sent
#Non-Terminating error- shows you an error but its not critical so not sginal is sent to terminate internal shell

Try{Get-ChildItem e:\dog.txt -ErrorAction Stop}
#run code in brackets and if a terminating error is being sent do what is in the catch block
catch{"no file exists"}