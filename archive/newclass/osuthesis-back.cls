\def\filename{osuthesis}
\def\fileversion{v0.1}
\def\filedate{2005/04/25}

%-----------------------------------------------------------------------
% Oregon State University Thesis Class
% John Metta (prev. name: Pennington) <john.metta@lifetime.oregonstate.edu>
%-----------------------------------------------------------------------
% Provides support for LyX OSU thesis textclass layouts.
%-----------------------------------------------------------------------
% Modified from:
% UQTHESIS.CLS by Daniel Jarrott <jarrott@itee.uq.edu.au>, ITEE, UQ.
%-----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\filename}[\filedate\space\fileversion\space%
         UQ thesis class]

% Pass all options through to the Book class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[]{book}

% The title page information
\newcommand{\currentdegrees}[1]{\gdef\@currentdegrees{#1}}
\newcommand{\school}[1]{\gdef\@school{#1}} 
\newcommand{\thesistype}[1]{\gdef\@thesistype{#1}}
\newcommand{\submitdate}[1]{\gdef\@submitdate{#1}}
\newcommand{\commencedate}[1]{\gdef\@commencedate{#1}}
\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1}} 
\newcommand{\degreetype}[1]{\gdef\@degreetype{#1}}

\renewcommand{\@title}{}
\renewcommand{\@author}{}
\newcommand{\@currentdegrees}{}
\newcommand{\@school}{Oregon State University}
\newcommand{\@thesistype}{}
\newcommand{\@degreetype}{}

\newcommand{\@submitdate}{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\ifnum\month=12
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \newcommand{\@copyrightyear}{\number\the\year}
\fi

\newcommand{\@commencedate}{June \space \@copyrightyear}

% the Title page
\renewcommand{\maketitle}{\pagenumbering{roman}%
        \begin{titlepage}%
	%\vfill
	\vspace*{20mm}
        \begin{center}
                {\Large\bf{\@title}}
		\vfill
 		{\normalsize{by}}
                \vfill
		{\large{\@author}}\\
		\vspace{2mm}
		{\normalsize{\@currentdegrees}}
	        \vfill
                {\normalsize\uppercase\expandafter{A \@degreetype}}
		\vfill
		{\normalsize{submitted to}}\\
		\vfill
		{\large{\@school}}\\
		\vspace{5mm}
		{\normalsize{in partial fulfillment of\\
		    the requirements for the\\
		    degree of}
		\vspace{5mm}
		{\large\expandafter{\@thesistype}}
		\vfill
		{\normalsize{Presented \@submitdate\\
		Commencement \@commencedate}}
        	\end{center}
	\vfill
	%\vspace*{20mm}
\end{titlepage}
} 

% Preface environments
% might need \pagesyle{empty} in here somewhere
\newcommand{\prefacesection}[1]{%
        \chapter*{#1}
        \addcontentsline{toc}{chapter}{#1}}
\newenvironment{statementoforiginality}
	{\prefacesection{Statement of originality}}%before
	{\\\vspace*{30mm}\\\@author\\\newpage}%after
\newenvironment{acknowledgements}
	{\prefacesection{Acknowledgments}}%before
	{}%after
\newenvironment{abstract}
	{\prefacesection{Abstract}}%before
	{\newpage}%after
%\newenvironment{}
%	{\prefacesection{}}%before
%	{\newpage}%after

% The main text
\newcommand{\startmaintext}[1]{\newpage\pagenumbering{arabic}}%

\endinput














