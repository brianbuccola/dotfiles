" Don't wrap lines when writing email.
set textwidth=0

" Silently remove 'your mail' when replying to a subjectless email.
silent %s/^Subject: Re: your mail$/Subject: Re:/
