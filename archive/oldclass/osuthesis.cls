%%
%% You shouldn't need to modify this.
%%
%% Ah, but LaTeX "should" be a real modular programming 
%% language, not a hacked-up text-substitution macro processor
%%

\ProvidesClass{osuthesis}[2000/06/22]
\NeedsTeXFormat{LaTeX2e}
 
%
% footnote stuff for option processing
%

\newwrite\tf@not

\newif\ifendnotes      % true if doing endnotes
  \endnotesfalse
\newif\ifchapternotes  % true if doing chapternotes
  \chapternotesfalse
\let\printchapternotes\relax
\let\printendnotes\relax
 
\DeclareOption{footnotes}% selects bottom-of-page notes (default)
  {}
\DeclareOption{chapternotes}% selects end-of-chapter notes
  {\chapternotestrue}
\DeclareOption{endnotes}% selects end-of-thesis notes
  {\endnotestrue}

%
% -----  Declerations ---------------------------------------------------
%
\newcommand{\Chapter}[1]{\chapter{#1}}
%
%----  Thesis is a modified 12-pt book style  ----------------------------
%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

%
%  Allow overriding
%
% \PassOptionsToClass{10pt}{book}
\DeclareOption{10pt}
  {\PassOptionsToClass{10pt}{book}}
\DeclareOption{11pt}
  {\PassOptionsToClass{11pt}{book}}
\DeclareOption{12pt}
  {\PassOptionsToClass{12pt}{book}}

\PassOptionsToClass{openany}{book}
\ProcessOptions
\LoadClass{book}

%
% margins are approximately 1 inch, except 1.5 inch at the binding
%

%\textheight 555\p@ \textwidth 430\p@
%\oddsidemargin 35\p@ \evensidemargin 0\p@
%\marginparwidth 72\p@ \marginparsep 7\p@
%\topmargin 0\p@   
%\headheight 12\p@ 
%\headsep 24\p@
%\footskip 12\p@
%\footskip 36pt
\footnotesep 1.5\baselineskip
%\footnotesep=14\p@
%\setlength\parindent{1.5em}


\def\baselinestretch{1.5}
\setcounter{totalnumber}{5}
\setcounter{topnumber}{5}

%VALENTINA
\setcounter{secnumdepth}{3}
%Vali: I needed this in order to have subsubsections numbered in the document text

\renewcommand\topfraction{.7}
\renewcommand\textfraction{.2}
\setlength\floatsep    {18\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\textfloatsep{30\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {20\p@ \@plus 4\p@ \@minus 4\p@}

%
%  ----  Footnotes  -----------------------
%
% Footnote placement option
%
%   [endnotes] put the references at the thesis end
%   [chapternotes] put the references at the chapter end
%   [footnotes] put the references at the page bottom
%
%   When text is written to file (.not) the source linebreaks
%   are maintained.  This keeps the individual lines in the file short.
%   Control sequences in the note text are not expanded.
%

\let\n@teitem\relax

\def\@chapternotetext{\begingroup
  \catcode`\^^M=12\newlinechar=`\^^M
  \catcode`\\=12
  \d@chapternote}

\long\def\d@chapternote#1{%
  \immediate \write\tf@not
      {\n@teitem[\note@label] #1\relax}%
  \endgroup}

%
\def\@startnotes{%  opens the .not file
  \immediate \openout\tf@not\jobname.not\relax
  \immediate \write\tf@not{\relax}
  %\setcounter{footnote}{0}
  }

%
% chapternotes
%

\ifchapternotes
  % \typeout{Doing chapternotes}
  \let\@footnotetext\@chapternotetext
  %\@startnotes
  \def\note@label{\arabic{footnote}}
  \def\printchapternotes{% Prints the accumulated notes
    \ifnum\c@footnote>1
      \clearpage
      \begin{center} Notes to Chapter \arabic{chapter} \end{center}\par
      \addcontentsline{toc}{section}{\protect
          \numberline{}{Notes to Chapter \arabic{chapter}}}
      \begin{description}
      \immediate\closeout\tf@not
      \catcode`@=11
      \let\n@teitem\item
      \@input{\jobname.not}
      \end{description}
      \clearpage
      %\@startnotes
    \fi
  }
  \let\old@enddocument\enddocument
  \def\enddocument{\printchapternotes\old@enddocument}
\fi

%
% endnotes
%

\ifendnotes
  % \typeout{Doing endnotes}
  \let\@footnotetext\@chapternotetext
  \@startnotes
  \def\note@label{\arabic{chapter}.\arabic{footnote}}
  \def\printendnotes{% Prints the accumulated notes
    \chapter*{Notes}
    \addcontentsline{toc}{chapter}{Notes}
    \thispagestyle{plain}
    \begin{description}
    \immediate\closeout\tf@not
    \catcode`@=11
    \let\n@teitem\item
    \@input{\jobname.not}
    \end{description}
    \@startnotes  % allows multiple endnotes
   }
\fi

%
%  bottom-of-page footnotes format
%  full width line and hanging indent
%
\def\footnoterule{\kern-3\p@
 \hrule width \columnwidth \kern 2.6\p@}
\long\def\@makefntext#1{\parindent 1em\noindent \hangindent\parindent
 \def\baselinestretch{1.0} \baselineskip=0pt
 \hbox to1em{\hss$^{\@thefnmark}\,$}#1}

%
%  ----  Text pages  ----------------------------------
%
%  In two-sided style Chapter 1 is right handed
%
\def\textofChapter#1{\gdef\@textofChapter{#1}}  \textofChapter{Chapter}
\def\textofAppendix#1{\gdef\@textofAppendix{#1}}  \textofAppendix{Appendix}

\def\textpages{% Start of text pages
   \clearpage\pagestyle{empty}
   \cleardoublepage\pagestyle{myheadings}\markboth{}{}
   \def\@chapapp{\protect\@textofChapter}
   \def\Thechapter{\arabic{chapter}}
   \pagenumbering{arabic}
%   \textheight 602pt  % allow for no footers (vers 1.3) #MINE#
%   \textheight 205mm  % allow for no footers (vers 1.3) #MINE#
% MINE
%%%
     %\footskip 0pt
     \footskip 36pt
   % \ifarchitect \textwidth 614pt \oddsidemargin 36pt \twocolumn\fi
   }
 
\def\appendix{\par
 \setcounter{chapter}{0}
 \setcounter{section}{0}
 \def\@chapapp{\protect\@textofAppendix}
 \def\Thechapter{\Alph{chapter}}
 \def\thechapter{\Alph{chapter}}}
 
 
%
%  Chapter headings
%
%
%  \def\@makechapterhead#1{\vspace*{2pc} {\centering
 %  \ifnum \c@secnumdepth >\m@ne {\bf CHAPTER \Thechapter} \par
 %  \vspace{10pt} \fi \bf \uppercase\expandafter{#1}\par
 %  \nobreak \vspace{20pt}} }
%  %
%  \def\@makeschapterhead#1{\vspace*{2pc} {\centering
 %  %\large\bf \uppercase\expandafter{#1}\par
 %  \bf \uppercase\expandafter{#1}\par
 %  \nobreak \vspace{20pt}} }

% \def\@makechapterhead#1{\vspace*{2pc} {\centering
\def\@makechapterhead#1{\vspace*{2pc} {\centering
 \ifnum \c@secnumdepth >\m@ne {\Large\bf Chapter \Thechapter:} \\*
 \vspace{10pt plus 2pt minus 1pt} \fi {\Large \bf \expandafter{#1}}\\
 \nobreak \vspace{20pt plus 2pt minus 1pt}} }
%
\def\@makeschapterhead#1{\vspace*{2pc} {\centering
 {\large\bf \expandafter{#1}}\\
 \nobreak \vspace{20pt plus 2pt minus 1pt}} }
%
\def\chapter{%
   \printchapternotes
   %\if@openright\cleardoublepage\else\clearpage\fi
   %\thispagestyle{empty}%
   \global\@topnum\z@
   \@afterindenttrue
%   \let\\\relax
   \secdef\@chapter\@schapter}
%
%  Complication is added here to allow line breaks
%  in the chapter titles (via \\).
%
\def\@chapter[#1]#2{
  \ifnum \c@secnumdepth >\m@ne
  \refstepcounter{chapter}
  \typeout{<<\thechapter>>}
  {\def\\{ }  % allow \\ in title
   \addcontentsline{toc}{chapter}{\protect
     \numberline{\@chapapp\ \thechapter:}#1}}\else
  {\def\\{ }  % allow \\ in title
   \addcontentsline{toc}{chapter}{#1}}\fi
 \addtocontents{lof}{\protect\addvspace{10pt}}
 \addtocontents{lot}{\protect\addvspace{10pt}}
 \if@twocolumn
  \@topnewpage[\@makechapterhead{#2}]
  \else \@makechapterhead{#2}
  \@afterheading \fi}
\def\@schapter#1{\if@twocolumn \@topnewpage[\@makeschapterhead{#1}]
  \else \@makeschapterhead{#1}
  \@afterheading\fi}



%
%  Section headings
%
\renewcommand\section{%
  \@startsection {section}{1}{\z@}% 
       %{-3.5ex \@plus -1ex \@minus -.2ex}%
       {-1.5\baselineskip}%before skip
       %{2.3ex \@plus.2ex}%
       {2.5ex\@plus 1ex \@minus 0.5ex}%
       %{\reset@font\def\baselinestretch{1.0}\normalsize\bfseries}}
       {\reset@font\def\baselinestretch{1.0}\large\bfseries}}
\renewcommand\subsection{%
  \@startsection{subsection}{2}{\z@}%
       {-1.5\baselineskip}%before skip
       %{1.5ex \@plus .2ex}%
       {2.5ex\@plus 1ex \@minus 0.5ex}%
       %{0.5\baselineskip}%after skip
       %{\reset@font\normalsize\slshape\bfseries}}
       %{\reset@font\normalsize\ttfamily\bfseries}}
       %{\reset@font\def\baselinestretch{1.0}\normalsize\itshape\bfseries}}
       {\reset@font\def\baselinestretch{1.0}\large}}
       %{\reset@font\normalsize\sffamily\bfseries}}
       %{\reset@font\normalsize\bfseries}}
       
\renewcommand\subsubsection{%
  \@startsection{subsubsection}{3}{\z@}%
       {-3.25ex\@plus -1ex \@minus -.2ex}%
       {-1.5\baselineskip}%before skip
       {1.5ex \@plus .2ex}%
       {\reset@font\def\baselinestretch{1.0}\normalsize\itshape}}

\renewcommand\subsubsection{%
  \@startsection{subsubsection}{3}{\z@}%
       {-1.5\baselineskip}%before skip
       {1.5ex \@plus .2ex}%
%       {1.5ex \@plus .2ex}%
       {\reset@font\def\baselinestretch{1.0}\normalsize\itshape}}

%\renewcommand\subsubsection{%
%  \@startsection{subsubsection}{3}{\z@}%
%       {-1.5\baselineskip}%before skip
%       {1.5ex \@plus .2ex}%
%       {\reset@font\def\baselinestretch{1.0}\normalsize\itshape}}

%
%  Provide for `Chapter ' in the toc
%  (increase \@tempdima)
%
\renewcommand\l@chapter[2]{%
\renewcommand{\baselinestretch}{1.00}
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{85pt}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode %\bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}



\def\l@chapter#1#2{\vskip 14pt {\baselineskip 14.5pt%
\@dottedtocline{1}{0pc}{6.2em}{#1}{#2}} \vskip 10pt} % changed forthesis style

\def\l@section#1#2{\vskip 8pt {\baselineskip 14.5pt%
\@dottedtocline{1}{1pc}{2.8em}{#1}{#2}} \vskip 6pt} % changed forthesis style
%
\def\l@subsection#1#2{ {\baselineskip 14.5pt%
\@dottedtocline{2}{4pc}{2.8em}{#1}{#2}}} % changed for thesis style
%
\def\l@subsubsection#1#2{{\baselineskip 14.5pt%
\@dottedtocline{3}{7pc}{3.4em}{#1}{#2}}}


%
% ------ Special captions ---------------------
%
% \caption[]{text} produces normal caption and numbering
% \caption(-){(continued)} produces `(continued)' caption and 
%        same-as-last caption number
% \caption(x)[]{text} produces lettered caption.  1.1a, 1.1b, ...
%        If (x) is (a) or (A) then caption number is incremented,
%        else it is same numbered.

\def\thecaptionletter{}
\newif\ifcaptiontotoc\captiontotoctrue
%
\def\caption{\@ifnextchar({\@specialcaption}{\@normalcaption}}
%
\def\@normalcaption{\refstepcounter\@captype \@dblarg{\@caption\@captype}}
\def\@specialcaption(#1){%
  \def\thecaptionletter{#1}%
  \captiontotocfalse
  \if#1-\def\thecaptionletter{}\fi
  \if#1a\refstepcounter\@captype\captiontotoctrue\fi
  \if#1A\refstepcounter\@captype\captiontotoctrue\fi
  \@dblarg{\@caption\@captype}}

\long\def\@caption#1[#2]#3{\par
  \ifcaptiontotoc
    \addcontentsline{\csname
    ext@#1\endcsname}{#1}{\protect\numberline{\csname
    the#1\endcsname}{\ignorespaces #2}}%
  \fi
  \begingroup
    \@parboxrestore
    \def\baselinestretch{1.0}
    \normalsize
    \vskip 14pt
    \@makecaption{\csname fnum@#1\endcsname
        \thecaptionletter}{\ignorespaces #3}\par
  \endgroup}
%
\def\@listI{\leftmargin\leftmargini \parsep 7pt plus 3pt minus 1pt\topsep
 12pt plus 5pt minus 6pt\itemsep 7pt plus 3pt minus 1pt}
% 
 
%
%  ----  Facing pages and double-page figures and tables
%
%  \begin{fullpage} ... \end{fullpage}
%  \begin{leftfullpage} ... \end{leftfullpage}

\newif\if@LP \@LPfalse

\newbox\@@wholepage
\def\fullpage{\setbox\@@wholepage=\vbox\bgroup}
\def\endfullpage{\egroup\dp\@@wholepage\z@
   \vbox to\textheight{\vss\unvbox\@@wholepage\vss}}
\def\leftfullpage{\setbox\@@wholepage=\vbox\bgroup}
\def\endleftfullpage{\egroup\dp\@@wholepage\z@
   \vbox to\textheight{\vss\unvbox\@@wholepage\vss}\global\@LPtrue}

\let\oldend@float\end@float
\def\end@float{%
  \if@LP\global\@namedef{LP:\expandafter\string\@currbox}{L}%
  \else \global\@namedef{LP:\expandafter\string\@currbox}{X}%
  \fi
   \global\@LPfalse
  \oldend@float
}


\if@twoside

% reject a left-side float that appears on an odd page
 \let\old@xtryfc\@xtryfc
 \def\@xtryfc #1{%
   \expandafter\if\csname LP:\string#1\endcsname L%
      % \typeout{facing page in xtryfc}%
      \ifodd\count0\global\@colht\z@
          \typeout{I moved a leftpage float from page \the\count0.}%
      \fi\fi
    \old@xtryfc #1}

\else

% flip a facing page caption
 \let\@oldwtryfc\@wtryfc
 \def\@wtryfc #1{%
  \expandafter\if\csname LP:\string#1\endcsname L\gdef\LP@page{}%
   % \typeout{facing page in wtryfc}%
   \fi
   \@oldwtryfc #1}

 \let\old@shipoutsetup\@shipoutsetup
 \def\@shipoutsetup{%
   \@ifundefined{LP@page}
     {\let\@themargin\oddsidemargin \let\@thehead\@oddhead}
     {\let\@themargin\evensidemargin \let\@thehead\@evenhead
      % \typeout{Formatting a left-hand one-side page.}%
      }
   \global\let\LP@page\relax
   \old@shipoutsetup
 }
\fi
%
%  Figures
%
\def\Figure#1{
	\vskip 42pt
	\figure{#1}
	\vskip 42pt
	}
%
%\renewcommand{\caption}[2]{\@startcaption
%	\vspace{0.5in}
%	\baselinestrech 1.0 
%	\normalsize
%	\{#1: #2}
%	\vspace{0.5in}
%}

%
%
%
%  ----  Preliminary pages  ---------------------------
%
\def\prelimpages{ % sets page numbering for the preliminary pages
   \pagestyle{empty} % will be {plain} at start of toc
   \pagenumbering{roman}
   \setcounter{page}{1}
%   \textheight 572pt  % add separation for page numbers (vers 1.3)
   \textheight 204.4mm  % add separation for page numbers (vers 1.3)
%      \footskip 0pt
      \footskip 30pt
   % \ifarchitect \textwidth 450pt \oddsidemargin 118pt\fi
   }
%
%      (The following macros are used once and discarded)
%
%  Title page
%
%  options and defaults
%
\def\Title#1{\gdef\@Title{#1}}
\def\Author#1{\gdef\@Author{#1}}
\def\Year#1{\gdef\@Year{#1}}  \Year{\year}
\def\Degree#1{\gdef\@Degree{#1}} \Degree{Doctor of Philosophy}
%
\def\School#1{\gdef\@School{#1}} \School{University of Washington}
\def\Degreetext#1{\gdef\@Degreetext{#1}} 
  \Degreetext{A dissertation submitted in partial fulfillment\\
    of the requirements for the degree of}
\newcount\@Signatures 
\def\Signatures#1{\global\@Signatures=#1\relax}
  \Signatures{3} % number of signature lines
 
\def\textofby#1{\gdef\@textofby{#1}}  \textofby{by}
\def\textofApproved#1{\gdef\@textofApproved{#1}}  \textofApproved{Approved by}
\def\textofChair#1{\gdef\@textofChair{#1}}  
       \textofChair{(Chairperson of Supervisory Committee)}
\def\textofProgram#1{\gdef\@textofProgram{#1}}  
       \textofProgram{Program Authorized}
\def\textoftoOffer#1{\gdef\@textoftoOffer{#1}}  
       \textoftoOffer{to Offer Degree}
\def\textofDate#1{\gdef\@textofDate{#1}}  \textofDate{Date}

\def\titlepage{                   % Prints the title page
    \vspace{7pc}
    \begin{center}
      {\Large
      \lineskip 3ex
      \@Title\par}
      \vskip0pt plus1fill\relax
      \@textofby
      \par\vskip0pt plus1fill\relax
      \@Author
      \par\vskip0pt plus2fill\relax
      \@Degreetext
      \par\vskip0pt plus2fill\relax
      \@Degree
      \par\vskip0pt plus2fill\relax
      \@School
      \par\vskip0pt plus1fill\relax
      \@Year
      \par\vskip0pt plus2fill\relax
     \makebox[\textwidth]{\@textofApproved\hrulefill}
      \par
      {\@textofChair}
      \par
      \@whilenum \@Signatures>1 \do
       {\vskip18pt
        \makebox[\textwidth]{\phantom{Approved by}\hrulefill}
        \advance\@Signatures by\m@ne}
      \par\vskip2pc
      \makebox[\textwidth]{\@textofProgram\hfill}
      \makebox[\textwidth]{\@textoftoOffer\hrulefill}
      \par\vskip2pc
      \makebox[\textwidth]{\@textofDate\hrulefill}
     \par
    \end{center}
     \vskip0pt plus2fill\relax
  \let\titlepage\relax}
 
%   Quote slip
%
\def\textofSignature#1{\gdef\@textofSignature{#1}}  \textofSignature{Signature}
\long\def\quoteslip#1{
   \cleardoublepage
   \null
   \vskip0pt plus1fill\relax
   \noindent #1\par
   \vskip3pc
   \begin{flushright}
      \makebox[3in]{\@textofSignature\hrulefill}
      \par\vskip2pc
      \makebox[3in]{\@textofDate\hrulefill}
   \end{flushright}
   \vskip0pt plus2fill\relax
   \let\quoteslip\relax}
%
%   Abstract
%
%  normal parameters
\def\textofAbstract#1{\gdef\@textofAbstract{#1}}  \textofAbstract{Abstract}
\def\textofChairSC#1{\gdef\@textofChairSC{#1}}  
       \textofChairSC{Chairperson of Supervisory Committee:}
\def\Professor#1{\gdef\@Professor{#1}}
\def\Department#1{\gdef\@Department{#1}}
\long\def\abstract#1{
   \cleardoublepage
   \begin{center}
      \@School
      \par\vskip1pc
      \@textofAbstract
      \par\vskip1pc
      {\Huge \@Title \par}
      \par\vskip1pc
      by \@Author
      \par\vskip1pc
      \@textofChairSC
         \begin{tabular}[t]{cc}\@Professor\\\@Department\end{tabular}
      \par\vskip1pc
   \end{center}
   #1
   \vfill
   \let\abstract\relax}
%
%
%   Table of contents (right side page) (always page `i')
%
\def\ps@toca{\def\@oddhead{\vbox to \headheight{
% \vskip 16mm
% \vskip 16mm
 \centerline{TABLE OF CONTENTS}\hfill \break
 \rm\flushright\protect\underline{Page}\break}}
 \def\@evenhead{}
 \def\@oddfoot{}
 \def\@evenfoot{}
 }
%
\def\ps@tocb{\def\@oddhead{\vbox to \headheight{
% \vskip 13mm
  \centerline{TABLE OF CONTENTS (Continued)}\hfil\break
  \rm\flushright\protect\underline{Page}\break}}
  \def\@evenhead{}
  \def\@oddfoot{}
  \def\@evenfoot{}
}
%
%\def\l@chapter#1#2{\vskip 9.5pt {\baselineskip 14.5pt%
%\@dottedtocline{0}{0pc}{2.8em}{#1}{#2}}} % changed for thesis style
%
%\def\l@section#1#2{ {\baselineskip 14.5pt%
%\@dottedtocline{1}{1pc}{2.8em}{#1}{#2}}} % changed for thesis style
%
%\def\l@subsection#1#2{ {\baselineskip 14.5pt%
%\@dottedtocline{2}{4pc}{2.8em}{#1}{#2}}} % changed for thesis style
%
%\def\l@subsubsection#1#2{\vskip 9.5pt{\baselineskip 14.5pt%
%\@dottedtocline{3}{5.5pc}{3.1em}{#1}{#2}}}
%
%\def\l@paragraph#1#2{\vskip 9.5pt{\baselineskip 14.5pt%
%\@dottedtocline{4}{6.5pc}{4.5em}{#1}{#2}}}
%
%\def\l@subparagraph#1#2{\vskip 9.5pt{\baselineskip 14.5pt%
%\@dottedtocline{5}{7.0pc}{2.5em}{#1}{#2}}}
%
%%%%%%%%%
%
%
%
\def\tableofcontents{\cleardoublepage
\vskip 10cm
   \pagestyle{tocb}
   \thispagestyle{toca}
   \setcounter{tocdepth}{2}
   {\let\footnotemark\relax  % in case one is in the title
   \@starttoc{toc}
    }
   }
   %
%\def\l@chapter#1#2{\vskip 10pt {\baselineskip 14.5pt%
%\@dottedtocline{1}{1pc}{2.8em}{#1}{#2}} } % changed for thesis style

\def\l@section#1#2{\vskip 4pt {\baselineskip 14.5pt%
\@dottedtocline{1}{1pc}{2.8em}{#1}{#2}} } % changed for thesis style
%
\def\l@subsection#1#2{ {\baselineskip 14.5pt%
\@dottedtocline{2}{4pc}{2.8em}{#1}{#2}}} % changed for thesis style
%
\def\l@subsubsection#1#2{{\baselineskip 14.5pt%
\@dottedtocline{3}{7pc}{3.4em}{#1}{#2}}}
%
%
%   List of figures
%
\def\ps@lofa{\def\@oddhead{\vbox to \headheight{
% \vskip 16mm
%  \vskip 0.2in
  \centerline{LIST OF FIGURES}\break
  \flushleft\underline{Figure}\hfill\underline{Page}\break}}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
}
%
\def\ps@lofb{\def\@oddhead{\vbox to \headheight{
% \vskip 13mm
%  \vskip 0.2in
  \centerline{LIST OF FIGURES (Continued)}\break
  \flushleft\underline{Figure}\hfill\underline{Page}\break}}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
}

%\def\@dotsep{2.5}

%
\def\l@figure#1#2{\vskip 9.5pt {\baselineskip 14.5pt%
\@dottedtocline{1}{1.5em}{2.3em}{#1}{#2}}}
\let\l@table\l@figure

\let\l@appendixtable\l@table
\let\l@appendixfigure\l@figure



\def\listoffigures{
   \cleardoublepage
   \pagestyle{lofb}
   \thispagestyle{lofa}
   {\let\footnotemark\relax  % in case one is in the title
   \@starttoc{lof}
    }
   }
%
%   List of tables
%
\def\ps@lota{\def\@oddhead{\vbox to \headheight{
% \vskip 16mm
%  \vskip 0.2in
  \centerline{LIST OF TABLES}\hfil\break\strut
  \rm\protect\underline{Table}\hfill
  \rm\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
   }

\def\ps@lotb{\def\@oddhead{\vbox to \headheight{
% \vskip 13mm
%  \vskip 0.2in
  \centerline{LIST OF TABLES (Continued)}\hfil\break\strut
  \rm\protect\underline{Table}\hfill
  \rm\hfill\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
 }

\def\ps@loata{\def\@oddhead{\vbox to \headheight{
%  \vskip 0.2in
% \vskip 13mm
  \centerline{LIST OF APPENDIX TABLES}\hfil\break\strut
  \rm\protect\underline{Table}\hfill
  \rm\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
   }

\def\ps@loatb{\def\@oddhead{\vbox to \headheight{
%  \vskip 0.2in
% \vskip 13mm
  \centerline{LIST OF APPENDIX TABLES (Continued)}\hfil\break\strut
  \rm\protect\underline{Table}\hfill
  \rm\hfill\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
}

\def\ps@loafa{\def\@oddhead{\vbox to \headheight{
%  \vskip 0.2in
% \vskip 13mm
  \centerline{LIST OF APPENDIX FIGURES}\hfil\break\strut
  \rm\protect\underline{Figure}\hfill
  \rm\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
   }

\def\ps@loafb{\def\@oddhead{\vbox to \headheight{
%  \vskip 0.2in
% \vskip 13mm
  \centerline{LIST OF APPENDIX FIGURES(Continued)}\hfil\break\strut
  \rm\protect\underline{Figure}\hfill
  \rm\hfill\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
 }
%
\def\listoftables{
   \cleardoublepage
   \pagestyle{lotb}
   \thispagestyle{lota}
   {\let\footnotemark\relax  % in case one is in the title
   \@starttoc{lot}
    }
   }

\def\listofappendixtables{
   \cleardoublepage
   \pagestyle{loatb}
   \thispagestyle{loata}
   {\let\footnotemark\relax  % in case one is in the title
   \@starttoc{loat}
    }
   }

\def\listofappendixfigures{
   \cleardoublepage
   \pagestyle{loafb}
   \thispagestyle{loafa}
   {\let\footnotemark\relax  % in case one is in the title
   \@starttoc{loaf}
    }
   }

%
%  Bibliography
%
\def\textofBIB#1{\gdef\@textofBIB{#1}}  \textofBIB{Bibliography}
\def\thebibliography#1{\chapter*{\@textofBIB\@mkboth{}{}}
 \addcontentsline{toc}{chapter}{\protect\@textofBIB}
 \list
 {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
 \advance\leftmargin\labelsep
 \usecounter{enumi}}
 \def\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax}
 

% Appendices
%

\def\textofAPP#1{\gdef\@textofAPP{#1}}  \textofAPP{Appendices}
%\def\thebibliography#1{\chapter*{\@textofAPP\@mkboth{}{}}
\def\textofAPP#1{\addcontentsline{toc}{chapter}{\protect\@textofAPP}}
% \list
% {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
% \advance\leftmargin\labelsep
% \usecounter{enumi}}
% \def\newblock{\hskip .11em plus .33em minus .07em}
% \sloppy\clubpenalty4000\widowpenalty4000
% \sfcode`\.=1000\relax}
 
\def\ps@loaa{\def\@oddhead{\vbox to \headheight{
  \centerline{LIST OF APPENDICES}\hfil\break\strut
  \rm\protect\underline{Table}\hfill
  \rm\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
   }

\def\ps@loab{\def\@oddhead{\vbox to \headheight{
  \centerline{LIST OF APPENDICES (Continued)}\hfil\break\strut
  \rm\protect\underline{Table}\hfill
  \rm\hfill\protect\underline{Page}\break }}
\def\@evenhead{}
\def\@oddfoot{}
\def\@evenfoot{}
 }
%
\def\listofappendices{
   \cleardoublepage
   \pagestyle{loab}
   \thispagestyle{loaa}
   {\let\footnotemark\relax  % in case one is in the title
   \@starttoc{loa}
    }
   }

%
%   Acknowledgments
%
\def\textofAck#1{\gdef\@textofAck{#1}}  \textofAck{Acknowledgments}
\long\def\acknowledgments#1{\chapter*{\@textofAck\@mkboth{}{}}
   \thispagestyle{plain}
   #1\par
   \vfill
   \let\acknowledgments\relax}
 
%
%   Dedication
%
\def\textofDed#1{\gdef\@textofDed{#1}}  \textofDed{Dedication}
\long\def\dedication#1{\chapter*{\@textofDed\@mkboth{}{}}
   \thispagestyle{plain}
   #1\par
   \vfill
   \let\dedication\relax}
 
%
%   Vita
%
\def\textofVita#1{\gdef\@textofVita{#1}}  \textofVita{Vita}
\long\def\vita#1{\chapter*{\@textofVita\@mkboth{}{}}
   #1\par
   \vfill
   \let\vita\relax}
 
%
%   Gratis definition of a glossary environment
%
\renewenvironment{glossary}
  {\begin{list}{}{\setlength\itemindent{\parindent}
   \def\makelabel##1{\footnotesize\uppercase{##1:}\hfill}}}
  {\end{list}}
% 
% SOME Definitions and Settings
%
\def\figurename{FIGURE}
\def\tablename{TABLE}
%\def\appendixtablename{TABLE}
\def\abstractname{Abstract}
%
%
%    These are now set in the thesis.tex file
% \setlength{\floatsep}{20pt}
% \setlength{\textfloatsep}{20pt}
% \setlength{\intextsep}{20pt}
% \setlength{\floatsep}{42pt}
% \setlength{\textfloatsep}{42pt}
% \setlength{\intextsep}{42pt}
%


%\newcommand{\listappendixtablename}{Appendix Table}

%\newcommand\listofappendixtables{%
%    \if@twocolumn
%      \@restonecoltrue\onecolumn
%    \else
%      \@restonecolfalse
%    \fi
%    \chapter*{\listappendixtablename
%      \@mkboth{%
%          \MakeUppercase\listappendixtablename}{\MakeUppercase\listappendixtablename XXX}}%
%    \@starttoc{loat}%
%    \if@restonecol\twocolumn\fi
%    }
%\let\l@appendixtable\l@table

\renewcommand\@tocrmarg{4.55em}
\renewcommand\@pnumwidth{3.55em}
