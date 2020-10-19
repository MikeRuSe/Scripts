## Powershell Script that converts an email list (row style) to Google Email Format (compatible in Google Contacts "contacts.google.com").
## Edit the $filepath and the $new_file vars.

$filepath = "A:\Downloads\emails.csv"
$new_file = "A:\Downloads\GoogleEmails_Format.csv"
$emails= (Import-CSV $filepath -Header A,B,C | Select-Object -Unique A | ConvertTo-Csv -NoTypeInformation)

"Name,Given Name,Additional Name,Family Name,Yomi Name,Given Name Yomi,Additional Name Yomi,Family Name Yomi,Name Prefix,Name Suffix,Initials,Nickname,Short Name,Maiden Name,Birthday,Gender,Location,Billing Information,Directory Server,Mileage,Occupation,Hobby,Sensitivity,Priority,Subject,Notes,Language,Photo,Group Membership,E-mail 1 - Type,E-mail 1 - Value" > $new_file
Foreach ($email in $emails) {
    $email = $email -replace '"',''
    if ($email -ne "A"){
     ",,,,,,,,,,,,,,,,,,,,,,,,,,,,USERS ::: * myContacts,* ," + $email >> $new_file
     }
}
