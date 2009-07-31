% osu-thesis.cls
%
%
%% This is a class (.cls) file for LaTeX2e.
%% This is a replacement for the dissertation.sty file used with
%% LaTeX209.  Basically we want the report class with a 
%% few modifications.
%%
%% Current Maintainer:  Norman Gall
%%                      Department of Philosophy
%%                      The University of Calgary
%%                      Calgary, Alberta, Canada
%%
%%                      ngall@ucalgary.ca (gall@spookyhill.net)
%%
%
% Version History
% ---------------
%
% v1.0  2005-05-09      Set up for limited distribution.
%
%-- Notes -------------------------------------------------------------
%
% This class file is horribly incomplete.
%
%-- Identification ----------------------------------------------------
%
\NeedsTeXFormat{LaTeX2e} \ProvidesClass{osu-thesis}[2005/05/09 v1.0]
%
%-- Initial Code ------------------------------------------------------
%
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{makeidx}
\RequirePackage{ulem}
%
%-- Declaration of Options -----------------------------
%
\newboolean{saving} \newboolean{half}
\DeclareOption{draft}{\setboolean{saving}{true}}
\DeclareOption{final}{\setboolean{saving}{false}}
\DeclareOption{half}{\setboolean{half}{true}}
\PassOptionsToClass{12pt}{report}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{draft}
%-- Execution of Options -------------------------------
\ProcessOptions
%-- Package Loading ------------------------------------
\LoadClass{report}
%-- Main Code ------------------------------------------
%%%
% 1. Preliminary Matter
%%%
%     some redefinitions I need later
%
\let\oldquote\quote
\let\oldendquote\endquote
\let\oldquotation\quotation
\let\oldendquotation\endquotation
\let\oldverse\verse
\let\oldendverse\endverse
\let\oldbibliography\bibliography
\let\oldendbibliography\endbibliography
\let\oldprintindex\printindex
%
%
\newboolean{masters}\setboolean{masters}{false}
\newboolean{hasfigures}\setboolean{hasfigures}{false}
\newboolean{hastables}\setboolean{hastables}{false}
%
\newcommand{\spacing}[1]{\renewcommand{\baselinestretch}{#1}%
                        \large\normalsize}
%
% \hugeskip - skip twice as much as the TeX command \bigskip
%
\def\hugeskip{\vskip 24pt plus 8pt minus 8pt}
%
% \@ifdefined - expand #2 if command #1 is not defined
%
\def\@ifdefined#1#2{\@ifundefined{#1}{}{#2}}
%
%
\def\thespacing#1{\gdef\@thespacing{#1}}
\ifthenelse{\boolean{half}}{\gdef\@thespacing{1.5}}{\gdef\@thespacing{2}}
%
\ifthenelse{\boolean{saving}}
{       % settings for draft
        \setlength {\topmargin}{0.0in}          % top margin    1.0in
        \setlength {\textheight}{\paperheight-2.5in} % bottom margin 1.0in
        \setlength {\oddsidemargin}{0.0in}      % left margin   1.0in
        \setlength {\evensidemargin}{0.0in}     % right margin (ds) 1.0in
        \setlength {\textwidth}{\paperwidth-2in} % right margin  1.0in
        \spacing{1}                             % single for drafts
}
{       % settings for final
        \setlength {\topmargin}{0.0in}         % top margin    1.0in
        \setlength {\textheight}{\paperheight-3.05in} % bottom margin 1.00in
        \setlength {\oddsidemargin}{0.65in}     % left margin   1.65in
        \setlength {\evensidemargin}{0.15in}    % right margin (ds)  1.15in
        \setlength {\textwidth}{\paperwidth-2.75in} % right margin  1.15in
        \setlength {\footskip}{0.3in}           % space above pg num
        \spacing{\@thespacing}                             % double for final
        \renewenvironment{quote}                % redefine quote 
                        {\oldquote\spacing{1}}
                        {\oldendquote\spacing{\@thespacing}}
        \renewenvironment{quotation}            % redefine quotation
                        {\oldquotation\spacing{1}}
                        {\oldendquotation\spacing{\@thespacing}} 
        \renewenvironment{verse}                % redefine verse
                        {\oldverse\spacing{1}}
                        {\oldendverse\spacing{\@thespacing}} 
}
\setlength {\footnotesep}{14pt}         
\setlength {\headheight}{2em}                 
\setlength {\headsep}{2em}
\renewenvironment{bibliography}[1]              % automatically enter toc line
        {\addcontentsline{toc}{chapter}{Bibliography}\oldbibliography {#1}}
                        {\oldendbibliography}
\renewcommand{\printindex}{\addcontentsline {toc}{chapter}{Index}\oldprintindex}
%
% define command that can undo footnote reset between chapters
% (shamelessly lifted from removefr.sty by Donald Arseneau) 
%
\def\@removefromreset#1#2{\let\@tempb\@elt
   \expandafter\let\expandafter\@tempa\csname c@#1\endcsname
   \def\@elt##1{\expandafter\ifx\csname c@##1\endcsname\@tempa\else
         \noexpand\@elt{##1}\fi}%
   \expandafter\edef\csname cl@#2\endcsname{\csname cl@#2\endcsname}%
   \let\@elt\@tempb}
%
% undo the hideous \@addtoreset in report.cls:
\@removefromreset{footnote}{chapter}
\def\resetfootnote{\setcounter{footnote}{0}}  % definition to reset footnote
%
%%%
% 2. Commands to define parameters for the front matter
%%% 
% There are two kinds of commands that define parametters for the  front
% matter:  those  that  provide info (like \author or \abstractfile) and
% those that set flags.
% 
% The following are the definitions of the commands  that  provide  info
% (standard  LaTeX  commands  like  \author are omitted because they are
% already defined).
%
\def\department#1{\gdef\@department{#1}}
\def\masterof#1{\gdef\@masterof{#1}}
\def\acknowledgementsfile#1{\gdef\@acknowledgementsfile{#1}}
\def\abstractfile#1{\gdef\@abstractfile{#1}}
\def\dedicationfile#1{\gdef\@dedicationfile{#1}}
\def\prefacefile#1{\gdef\@prefacefile{#1}}
\def\approvalpagefile#1{\gdef\@approvalpagefile{#1}}
\def\degreename#1{\gdef\@degreename{#1}}
\def\major#1{\gdef\@major{#1}}
\def\majorprof#1{\gdef\@majorprof{#1}}
\def\commencementdate#1{\gdef\@commencementdate{#1}}
%
\def\toccont{\large TABLE OF CONTENTS (Continued)}
\def\lofcont{\large LIST OF FIGURES (Continued)}
\def\lotcont{\large LIST OF TABLES (Continued)}
%
\ifthenelse{\boolean{masters}}{\gdef\@degreename{Master}}%
                              {\gdef\@degreename{Doctor}}
%
\def\ruleline{\hbox to \hsize{\hrulefill} \vspace*{-.5ex}}
%%%
% 3. Generate frontmatter
%%%        
%
\def\makefrontmatter{
 \pagestyle {empty}
 \@ifdefined {@abstractfile}{\makeabstract}{}
 \makecopyrightpage
 \maketitlepage
 \makeapprovalpage
 \@ifdefined {@acknowledgementsfile}{\makeacknowledgements}{}
  \tableofcontents
 \ifthenelse{\boolean{hasfigures}}{\makelistoffigures}{}
 \ifthenelse{\boolean{hastables}}{\makelistoftables}{}
 \@ifdefined {@dedicationfile}{\makededication}{}
 \@ifdefined {@prefacefile}{\makepreface}{}
 \pagenumbering {arabic}
 \setcounter {page}{0}
 \thispagestyle {empty}
 \pagestyle {myheadings}
 \markright{ }
 }
%
% \makeabstract - create the abstract
%
\def\makeabstract{
  {\spacing{1}
 \noindent AN ABSTRACT OF THE THESIS OF

 \hugeskip
 \noindent \uline{\@author} for the degree of 
 \uline{\@degreename\ of \@masterof} in \\
 \uline{\@major} presented on \uline{\@date}.

 \hugeskip
 \noindent  Title: \uline{\@title}
 \hugeskip 
 \noindent Abstract Approved:

 \hugeskip \hugeskip
 \ruleline \hbox to \textwidth{\hfil \@majorprof \hfil}}
 
 \hugeskip \hugeskip
 \noindent
 \@input{\@abstractfile}
}
%
% \makecopyrightpage - create a copyright page
%
\def\makecopyrightpage{
 \newpage
  \par\vspace*{\stretch{1}}
  {\spacing{1.5}
  \begin{center}
     $\copyright$Copyright by \@author \par
    Defense Date \@date \par
    All Rights Reserved
  \end{center}}
  \vspace*{\stretch{2}}
}
%
% \maketitlepage - create the title page according to a complex format
%
\def\maketitlepage{
 \newpage
 \begin{center}
{\spacing{1}
 \begin{tabular}[t]{c}
   \@title
 \end{tabular}
 \hugeskip \hugeskip \hugeskip
 by \\  \@author
 \hugeskip \hugeskip \hugeskip \hugeskip \hugeskip \hugeskip
 \ifmasters A THESIS \else A DISSERTATION \fi
          \hugeskip
          submitted to \\
          \hugeskip
          Oregon State University
          \hugeskip \hugeskip
          in partial fulfillment of \\
          the requirements for the \\ 
          degree of
 \hugeskip
 \ifmasters \@degreename\ of \@masterof \else \@degreename\ of Philosophy \fi
 \hugeskip \hugeskip \hugeskip
 Presented \@date \\
 Commencement June \number\year}
 \end{center}
}
%
% \makeapprovalpage - create an approval page
%                     just a general one
%
\def\makeapprovalpage{
 \newpage
 {\spacing{1}
 \noindent
 \uline{\@degreename\ of \@masterof} thesis of \uline{\@author} presented 
 on \uline{\@date}

 \hugeskip \hugeskip
 \noindent APPROVED:

 \hugeskip
 \ruleline
 \noindent Major Professor, representing \@major

 \hugeskip
 \ruleline
 \noindent Director of the Department of \@department

 \hugeskip
 \ruleline
 \noindent Dean of the Graduate School

 \hugeskip \hugeskip \hugeskip
 \noindent I understand that my thesis will become part of the permanent
 collection of Oregon State University libraries.  My signature below
 authorizes release of my thesis to any reader upon request.

 \bigskip
 \ruleline \hbox to \textwidth{\hfil \@author, Author \hfil}}
 \newpage
 {\spacing{1}
 \noindent
 \uline{\@degreename\ of \@masterof} thesis of \uline{\@author} presented 
 on \uline{\@date}

 \hugeskip \hugeskip
 \noindent APPROVED:

 \hugeskip
 \ruleline
 \noindent Major Professor, representing \@major

 \hugeskip
 \ruleline
 \noindent Associate Director of the Department of \@department

 \hugeskip
 \ruleline
 \noindent Dean of the Graduate School

 \hugeskip \hugeskip \hugeskip
 \noindent I understand that my thesis will become part of the permanent
 collection of Oregon State University libraries.  My signature below
 authorizes release of my thesis to any reader upon request.

 \bigskip
 \ruleline \hbox to \textwidth{\hfil \@author, Author \hfil}}
}
%
% \makeacknowledgements - create the acknowledgements
%
\def\makeacknowledgements{
 \newpage
 \chapter*{ACKNOWLEDGEMENTS}
 \noindent
 \@input{\@acknowledgementsfile}
}
%
% \makededication - create the dedication
%
\def\makededication{
 \newpage
 \vspace*{\stretch{1}}
 \@input{\@dedicationfile}
 \vspace*{\stretch{2}}
}
%
% \makepreface - create the preface
%
\def\makepreface{
 \newpage
 \chapter*{PREFACE}
 \noindent
 \@input{\@prefacefile}
}
%
% \makelistoftables - create the list of tables
%
\def\makelistoftables{
 \listoftables
}
%
% \makelistoffigures  - create the list of figures
%
\def\makelistoffigures{
 \listoffigures
}
%
% end making frontmatter
%
%%%%
% 3. Set text displays
%%%%

%
% \@makechapterhead \@makeschapterhead - create a chapter head
%
% These standard LaTeX commands are redefined here to use not-so-huge type
%
\newcommand\FirstChapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \global\@topnum\z@
                    \@afterindentfalse
                    \begin{center}
                       \noindent\large \@title \\
                    \end{center}
                    \secdef\@chapter\@schapter}
%
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@makechapterhead#1{%
  \vspace*{30\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \Large \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \Large #1\par\nobreak
    \vskip 40\p@
  }}
%
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \large #1\par\nobreak
    \vskip 40\p@
  }}
\renewcommand\part{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}
%
% redefine section size to the same size as subsection, etc.
%
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                    {-3.5ex \@plus -1ex \@minus -.2ex}%
                                    {2.3ex \@plus.2ex}%
                                    {\normalfont\large\bfseries}}
                                   
\renewcommand\subsection{\@startsection {subsection}{1}{\z@}%
                                    {-3.5ex \@plus -1ex \@minus -.2ex}%
                                    {2.3ex \@plus.2ex}%
                                    {\normalfont\normalsize\bfseries}}

\renewcommand\subsubsection{\@startsection {subsubsection}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\normalsize\bfseries}}
%
% First we rename the headings for the toc, lof, and the references.
%
\renewcommand\contentsname{TABLE OF CONTENTS}
\renewcommand\listfigurename{LIST OF FIGURES}
\renewcommand\listtablename{LIST OF TABLES}
%
% next we modify the definitions of \tableofcontents, \listoffigures,
% and \listoftables.  We need to have \underline{Section}   
% \underline{Page} and so forth....  basically we add the contentsheader 
% line to each of the standard definitions 
%
\newcommand{\contentsheader}[2]
{       \addtocontents{#1}
        {       \centerline{\underline{#2}\protect\hfill%
                           \underline{Page}}%
        }%
}
%
\renewcommand\tableofcontents
{       \chapter*{\contentsname \@mkboth        {\uppercase{\contentsname}}%
                                                {\uppercase{\contentsname}}}%
        \thispagestyle {empty}
        \@starttoc{toc}%
 }
%
\renewcommand\listoffigures
{       \chapter*{\listfigurename \@mkboth      {\uppercase{\listfigurename}}%
                                                {\uppercase{\listfigurename}}}%
        \@starttoc{lof}%
 }
%
\renewcommand\listoftables
{       \chapter*{\listtablename \@mkboth       {\uppercase{\listtablename}}%
                                                {\uppercase{\listtablename}}}%
        \@starttoc{lot}%
}
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}%
    \endgroup
  \fi}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}

%%%
% 4. Other new commands and environments
%%%

%
%% End of file `osu-thesis.cls'.







