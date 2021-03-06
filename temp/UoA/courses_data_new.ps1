﻿$serverName = "<<server>>.database.windows.net"
$databaseName ="mydb"
$userName = "labuser"
$password = "password"

function getData_New ($course, $URI)
{

    $HTML = Invoke-WebRequest -Uri $URI
    $elements = $HTML.ParsedHtml.body.getElementsByClassName('coursePaper section') | Select OuterHTML

    ##Clear-Host

    foreach($element in $elements)
    {
        ConvertTo-Html -Body $element.outerHTML | Out-File "C:\temp\a.html"
        $innerHTML = New-Object -ComObject 'HTMLFILE'
        $src = Get-Content -Path 'C:\temp\a.html' -Raw
        $innerHTML.IHTMLDocument2_write($src)

        Write-Host '----------------------------------------------------------------'
        <#
        $innerHTML.body.getElementsByClassName('courseA') | Select className, InnerText
        $innerHTML.body.getElementsByClassName('points') | Select className, InnerText
        $innerHTML.body.getElementsByClassName('title') | Select className, InnerText
        $innerHTML.body.getElementsByClassName('description') | Select className, InnerText
        $innerHTML.body.getElementsByClassName('prerequisite') | Select className, InnerText
        #>
        $courseA = $innerHTML.body.getElementsByClassName('courseA') | Select InnerText
        if ($courseA.innerText.Length -eq 0) 
        {
            $courseA = ''
        }
        else
        {
            $courseA = $courseA.innerText.ToString()
        }

        $points = $innerHTML.body.getElementsByClassName('points') | Select InnerText
        if ($points.innerText.Length -eq 0) 
        {
            $points = ''
        }
        else
        {
            $points = $points.innerText.ToString()
             $points = $points -replace "'", "''"
        }

        $title = $innerHTML.body.getElementsByClassName('title') | Select InnerText
        if ($title.innerText.Length -eq 0) 
        {
            $title = ''
        }
        else
        {
            $title = $title.innerText.ToString()
             $title = $title -replace "'", "''"
        }
        
        $description = $innerHTML.body.getElementsByClassName('description') | Select InnerText
        if ($description.innerText.Length -eq 0) 
        {
            $description = ''
        }
        else
        {
            $description = $description.innerText.ToString()
            $description = $description -replace "'", "''"
        }

        $prerequisites = $innerHTML.body.getElementsByClassName('prerequisite') | Select InnerText
        if ($prerequisites.innerText.Length -eq 0) 
        {
            $prerequisite = ''
            $restrcition = ''
        }
        else
        {
            if ($prerequisites.Count -gt 1)
            {
            $prerequisite.Count 

                $prerequisite = $prerequisites[0].innerText.ToString() 
                $prerequisite = $prerequisite -replace "'", "''"
                $restrcition = $prerequisites[1].innerText.ToString()
                $restrcition = $restrcition -replace "'", "''"
            }
            else
            {
                $prerequisite = $prerequisites.innerText.ToString()
                $prerequisite = $prerequisite -replace "'", "''"
                $restrcition = ''
            }
        }
                
        $query 

        $query = "INSERT INTO tb_temp_course_new(courses, courseA, points, title, [description], prerequisite, Restriction) VALUES('" + $course + "', '" + $courseA + "', '" + $points + "', '" + $title + "', '" + $description + "', '" + $prerequisite + "', '" + $restrcition + "')"

        Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Username $userName -Password $password -Query $query | Format-Table
       
    }
}


$CourseURI  = "https://www.calendar.auckland.ac.nz/en/courses/faculty-of-engineering.html"
$CourseHTML = Invoke-WebRequest -Uri $CourseURI
$Links = $CourseHTML.ParsedHtml.body.getElementsByClassName('linkTxt') 


foreach ($Link in $Links)
{
    getData_New $Link.textContent $Link.href
}
