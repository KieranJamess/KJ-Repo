Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(837,648)
$Form.text                       = "Site Checker"
$Form.TopMost                    = $false

function Get-UrlStatusCode([string] $Url)
{
    try
    {
        (Invoke-WebRequest -Uri $Url -UseBasicParsing -DisableKeepAlive).StatusCode
    }
    catch [Net.WebException]
    {
        [int]$_.Exception.Response.StatusCode
    }
}
function Checksite {
    param (
    [Parameter()]
    [int]
    $notinstock = 0,

    [Parameter()]
    [int]
    $totalchecks = 0,

    [Parameter()]
    [int]
    $checkintervals = 0,

    [Parameter()]
    [string]
    $smtpserver,

    [Parameter()]
    [string]
    $fromemail,

    [Parameter()]
    [string]
    $toemail,

    [Parameter()]
    [string]
    $subject,

    [Parameter()]
    [string]
    $body,

    [Parameter()]
    [string]
    $sitename,

    [Parameter()]
    [string]
    $link,

    [Parameter()]
    [string]
    $textocheck,

    [Parameter()]
    [string]
    $emailp,

    [Parameter()]
    [string]
    $product
)

$output.text="Checking Site: $sitename for $product `r`n" 

    DO {
        [System.Windows.Forms.Application]::DoEvents() 
        $sitestatus = Get-UrlStatusCode -Url $link
        if ($sitestatus -eq 200) {
            $totalchecks = $totalchecks + 1
            wget $link -outfile ".\$sitename.txt"
            $status = Get-Content -Path ".\$sitename.txt"
            if ($status -match $textocheck) {
                write-host "[ $sitestatus ] $sitename : $product unavailable!"
                $output.Appendtext("[ $sitestatus ] $sitename : $product unavailable!`r`n")
                Start-Sleep -Seconds $checkintervals
            }
            else {
                $notinstock = 1  
            }
        }
        else {
            Write-host "[ $sitestatus ] The link for $sitename is returning $sitestatus`r`n" -ForegroundColor Red
        }
    } until ($notinstock -eq 1)
    write-host "[ $sitestatus ] $sitename : $product is available!`r`n" -ForegroundColor Green
    Write-host "Total Checks: $totalchecks "-ForegroundColor Green
    Send-MailMessage -Body $body `
    -From $fromemail `
    -to $toemail `
    -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $fromemail ,(Get-Content -Path .\email.securestring | ConvertTo-SecureString)) `
    -SmtpServer $smtpserver `
    -Subject $subject `
    -Encoding UTF8 `
    -UseSsl
}

$FromEmail                       = New-Object system.Windows.Forms.TextBox
$FromEmail.multiline             = $false
$FromEmail.text                  = " "
$FromEmail.width                 = 813
$FromEmail.height                = 20
$FromEmail.location              = New-Object System.Drawing.Point(8,39)
$FromEmail.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LabelFromEmail                  = New-Object system.Windows.Forms.Label
$LabelFromEmail.text             = "From Email"
$LabelFromEmail.AutoSize         = $true
$LabelFromEmail.width            = 25
$LabelFromEmail.height           = 10
$LabelFromEmail.location         = New-Object System.Drawing.Point(13,19)
$LabelFromEmail.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ToEmail                         = New-Object system.Windows.Forms.TextBox
$ToEmail.multiline               = $false
$ToEmail.text                    = " "
$ToEmail.width                   = 813
$ToEmail.height                  = 20
$ToEmail.location                = New-Object System.Drawing.Point(8,84)
$ToEmail.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ToEmailLabel                    = New-Object system.Windows.Forms.Label
$ToEmailLabel.text               = "To Email"
$ToEmailLabel.AutoSize           = $true
$ToEmailLabel.width              = 25
$ToEmailLabel.height             = 10
$ToEmailLabel.location           = New-Object System.Drawing.Point(13,65)
$ToEmailLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SMTPServerLabel                 = New-Object system.Windows.Forms.Label
$SMTPServerLabel.text            = "SMTP Server"
$SMTPServerLabel.AutoSize        = $true
$SMTPServerLabel.width           = 5
$SMTPServerLabel.height          = 10
$SMTPServerLabel.location        = New-Object System.Drawing.Point(13,110)
$SMTPServerLabel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SMTPserver                      = New-Object system.Windows.Forms.TextBox
$SMTPserver.multiline            = $false
$SMTPserver.text                 = "smtp.gmail.com"
$SMTPserver.width                = 387
$SMTPserver.height               = 20
$SMTPserver.location             = New-Object System.Drawing.Point(8,129)
$SMTPserver.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Subject                         = New-Object system.Windows.Forms.TextBox
$Subject.multiline               = $false
$Subject.text                    = " "
$Subject.width                   = 401
$Subject.height                  = 20
$Subject.location                = New-Object System.Drawing.Point(419,129)
$Subject.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$SubjectLabel                    = New-Object system.Windows.Forms.Label
$SubjectLabel.text               = " "
$SubjectLabel.AutoSize           = $true
$SubjectLabel.width              = 5
$SubjectLabel.height             = 10
$SubjectLabel.location           = New-Object System.Drawing.Point(422,109)
$SubjectLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Body                            = New-Object system.Windows.Forms.TextBox
$Body.multiline                  = $false
$Body.text                       = " "
$Body.width                      = 812
$Body.height                     = 20
$Body.location                   = New-Object System.Drawing.Point(8,173)
$Body.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$BodyLabel                       = New-Object system.Windows.Forms.Label
$BodyLabel.text                  = "Body"
$BodyLabel.AutoSize              = $true
$BodyLabel.width                 = 25
$BodyLabel.height                = 10
$BodyLabel.location              = New-Object System.Drawing.Point(13,154)
$BodyLabel.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$EmailPasswordLabel              = New-Object system.Windows.Forms.Label
$EmailPasswordLabel.text         = "Email Password"
$EmailPasswordLabel.AutoSize     = $true
$EmailPasswordLabel.width        = 25
$EmailPasswordLabel.height       = 10
$EmailPasswordLabel.location     = New-Object System.Drawing.Point(14,201)
$EmailPasswordLabel.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$EmailPassword                   = New-Object System.Windows.Forms.TextBox
$EmailPassword.PasswordChar      = '*'
$EmailPassword.multiline         = $false
$EmailPassword.width             = 690
$EmailPassword.height            = 20
$EmailPassword.visible           = $true
$EmailPassword.location          = New-Object System.Drawing.Point(9,220)
$EmailPassword.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Intervallabel                   = New-Object system.Windows.Forms.Label
$Intervallabel.text              = "Interval"
$Intervallabel.AutoSize          = $true
$Intervallabel.width             = 42
$Intervallabel.height            = 10
$Intervallabel.location          = New-Object System.Drawing.Point(717,206)
$Intervallabel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Interval                        = New-Object system.Windows.Forms.TextBox
$Interval.multiline              = $false
$Interval.text                   = " "
$Interval.width                  = 107
$Interval.height                 = 20
$Interval.visible                = $true
$Interval.location               = New-Object System.Drawing.Point(713,222)
$Interval.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$sitenamelabel                   = New-Object system.Windows.Forms.Label
$sitenamelabel.text              = "Site Name"
$sitenamelabel.AutoSize          = $true
$sitenamelabel.width             = 5
$sitenamelabel.height            = 10
$sitenamelabel.location          = New-Object System.Drawing.Point(14,249)
$sitenamelabel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$sitename                        = New-Object system.Windows.Forms.TextBox
$sitename.multiline              = $false
$sitename.text                   = " "
$sitename.width                  = 177
$sitename.height                 = 20
$sitename.location               = New-Object System.Drawing.Point(9,268)
$sitename.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$WinForm1                        = New-Object system.Windows.Forms.Form
$WinForm1.ClientSize             = New-Object System.Drawing.Point(401,648)
$WinForm1.text                   = "Site Checker"
$WinForm1.TopMost                = $false

$LinkLabel                       = New-Object system.Windows.Forms.Label
$LinkLabel.text                  = "Link"
$LinkLabel.AutoSize              = $true
$LinkLabel.width                 = 438
$LinkLabel.height                = 10
$LinkLabel.location              = New-Object System.Drawing.Point(203,248)
$LinkLabel.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.text                   = " "
$TextBox2.width                  = 625
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(197,268)
$TextBox2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$CheckTextLabel                  = New-Object system.Windows.Forms.Label
$CheckTextLabel.text             = "Text to check"
$CheckTextLabel.AutoSize         = $true
$CheckTextLabel.width            = 25
$CheckTextLabel.height           = 10
$CheckTextLabel.location         = New-Object System.Drawing.Point(15,297)
$CheckTextLabel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$checktext                       = New-Object system.Windows.Forms.TextBox
$checktext.multiline             = $false
$checktext.text                  = " "
$checktext.width                 = 813
$checktext.height                = 20
$checktext.location              = New-Object System.Drawing.Point(10,316)
$checktext.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Output                          = New-Object System.Windows.Forms.TextBox
$Output.height                   = 200
$Output.width                    = 800
$Output.location                 = New-Object System.Drawing.Point(10,419)
$output.text                     = "Null"
$output.MultiLine                = $True
$output.ScrollBars               = "Vertical"

$ProductLabel                    = New-Object system.Windows.Forms.Label
$ProductLabel.text               = "Product"
$ProductLabel.AutoSize           = $true
$ProductLabel.width              = 25
$ProductLabel.height             = 10
$ProductLabel.location           = New-Object System.Drawing.Point(10,337)
$ProductLabel.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Product                         = New-Object system.Windows.Forms.TextBox
$Product.multiline               = $false
$Product.text                    = " "
$Product.width                   = 813
$Product.height                  = 20
$Product.location                = New-Object System.Drawing.Point(8,356)
$Product.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Run                             = New-Object system.Windows.Forms.Button
$Run.text                        = "Run"
$Run.width                       = 812
$Run.height                      = 30
$Run.location                    = New-Object System.Drawing.Point(10,380)
$Run.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Run.BackColor                   = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Run.Add_Click({
    [System.Windows.Forms.Application]::DoEvents()
    ConvertTo-SecureString $EmailPassword.Text -AsPlainText -Force | ConvertFrom-SecureString | Out-File -FilePath .\email.securestring
    CheckSite `
    -fromemail $FromEmail.Text `
    -toemail $ToEmail.Text `
    -smtpserver $SMTPserver.Text `
    -subject $Subject.Text `
    -body $Body.text `
    -checkintervals $Interval.Text `
    -sitename $sitename.text `
    -link $TextBox2.text `
    -textocheck $checktext.text `
    -product $product.text 
})

$Form.controls.AddRange(@($FromEmail,$LabelFromEmail,$ToEmail,$ToEmailLabel,$SMTPServerLabel,$SMTPserver,$Subject,$SubjectLabel,$Body,$BodyLabel,$EmailPasswordLabel,$EmailPassword,$Intervallabel,$Interval,$Run,$sitenamelabel,$sitename,$LinkLabel,$TextBox2,$CheckTextLabel,$checktext,$Output,$productlabel,$product))

[void]$Form.ShowDialog()
