%
% CLASS FOR PHD THESIS
%
% This file uses the standard report class
%
%
% Jurgen van Zundert
% based on bbthesis.cls (version 01: 22-10-2011) by Bart Besselink (BART), and Benjamin Biemond (minor changes) (BB)


\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{phdthesis}[2018/06/22 PhD thesis class]


%%% LOAD REPORT CLASS %%%
\LoadClass[openright,twoside]{report}
\AtEndDocument{\clearpage\thispagestyle{empty}\cleardoublepage} %Ensure even number of pages

%%% USE GEOMETRY PACKAGE TO SET PAPER SIZE %%%
% set options for geometry package
% geometry package for MikTeX 2.9 at home
\edef\geometryoptions{[twoside]}

% load geometry package
\expandafter\RequirePackage\geometryoptions{geometry}
\geometry{
% PAGE BLEED: 0 mm
%    paperwidth  = 170mm,
%    paperheight = 240mm,
%    textheight  = 183mm,
%    textwidth   = 122mm,
%    headsep     =   7mm,
%    headheight  =  12pt,
%    footskip    =  30pt,
%    top         =  32mm,
%    inner       =  26mm % to center, set 24mm
% PAGE BLEED: 2 mm
    paperwidth  = 174mm,
    paperheight = 244mm,
    textheight  = 183mm,
    textwidth   = 122mm,
    headsep     =   7mm,
    headheight  =  12pt,
    footskip    =  30pt,
    top         =  34mm,% = 32+2mm margin+bleed; then bottom = 25+2mm margin+bleed
    inner       =  28mm % = 26+2mm margin+bleed; then outer = 22+2mm margin+bleed; to center, set 24+2=26mm
}


%%% DEFINE HEADERS %%%
\RequirePackage{fancyhdr}
\RequirePackage{rotating}

% set headers and footers
\pagestyle{fancy}
\fancyhead{}
\fancyhead[RO,LE]{\thepage}
%\fancyhead[LO]{\slshape\rightmark}
%\fancyhead[RE]{\slshape\leftmark}
\fancyhead[LO]{\sffamily\itshape\nouppercase\rightmark}
\fancyhead[RE]{\sffamily\itshape\nouppercase\leftmark}
\fancyfoot{}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}

\renewcommand{\chaptermark}[1]{\markboth{\@chapapp\ \thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\hspace{0.1cm} #1}}

% remove page number on plain pages
\fancypagestyle{plain}{%
  \fancyhead{}
  \fancyfoot{}
  \renewcommand{\headrulewidth}{0pt}
}


%%% DEFINE CHAPTERNOTE WITHOUT NUMBER %%%
\newcommand{\chapternote}[1]{{\let\thempfn\relax\footnotetext[0]{#1}}}

%%% MAKE SURE THAT EMPTY PAGES BEFORE A NEW CHAPTER ARE REALLY EMPTY %%%
\renewcommand\chapter{\if@openright%
                        %\clearpage\thispagestyle{empty}\cleardoublepage% thumb-index also on chapter page
                        \clearpage\Materialfalse\thispagestyle{empty}\cleardoublepage% thumb-index not on chapter page
                      \else\clearpage\fi%
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}


%\RequirePackage[raggedright,toctitles]{titlesec} % Long section titles + optional argument section only used in header (not in toc) (does not work for chapters --> use \chaptermark{})
\RequirePackage[raggedright]{titlesec} % use optional argument also in toc


%\titleformat

% Bold math in section headers: add \boldmath to default definitions \RequirePackage{sectsty}\allsectionsfont{\boldmath} not compatible with titlesec package
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries\boldmath\raggedright}{\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}
{\normalfont\Large\bfseries\boldmath\raggedright}{\thesection}{1em}{}
\titleformat{\subsection}
{\normalfont\large\bfseries\boldmath\raggedright}{\thesubsection}{1em}{}
\titleformat{\subsubsection}[runin]
{\normalfont\normalsize\bfseries\boldmath\raggedright}{\thesubsubsection}{1em}{}[:] %add semicolon after head
\titleformat{\paragraph}[runin]
{\normalfont\normalsize\bfseries\boldmath\raggedright}{\theparagraph}{1em}{}
\titleformat{\subparagraph}[runin]
{\normalfont\normalsize\bfseries\boldmath\raggedright}{\thesubparagraph}{1em}{}


%%% DEFINE CHAPTER LAYOUT %%%
% adapted from report.cls
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \LARGE\bfseries\raggedleft \@chapapp\space\thechapter
        \par\nobreak
        \vskip 10\p@
        \rule{\textwidth}{6pt}
        \vskip 10\p@
    \fi
    \interlinepenalty\@M
    \huge\bfseries\raggedleft #1
    \par\nobreak
    \vskip 0\p@
    \rule{\textwidth}{0.6pt}
    \vskip 20\p@
  }%
}

%%% CHAPTER LAYOUT WITHOUT NUMBER (FOR TOC, BIB, ETC.) %%%
\def\@makeschapterhead#1{%
  \vspace*{50\p@}% standard 50, change to less if space is required on first page of toc
  {\parindent \z@ \raggedright
        \vskip 10\p@
        \rule{\textwidth}{.6pt}
        \vskip 10\p@
    \normalfont
    \interlinepenalty\@M
    \huge\bfseries\raggedleft  #1
    \par\nobreak
    \vskip 0\p@
    \rule{\textwidth}{0.6pt}
    \vskip 20\p@
  }}


% Unnumbered chapter with chapter mark and pdfbookmark
\newcommand{\chapterstar}[1]{
\chapter*{#1}%
\pdfbookmark[0]{#1}{#1}%
\@mkboth{#1}{#1}%
}

% Unnumbered chapter with chapter mark and in toc (pdf bookmark added by toc)
\newcommand{\chapterstartoc}[1]{
\chapter*{#1}%
\@mkboth{#1}{#1}%
\addcontentsline{toc}{chapter}{\texorpdfstring{#1}{#1}}%
}

%%% RENEW COMMANDS TOC AND BIB TO ADOPT HEADERS %%%
\setcounter{tocdepth}{1}
\setcounter{secnumdepth}{3}

\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{\contentsname}{\contentsname}}%
	%\vspace{-8pt}% makes chapter 2 fit completely on first page
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }

%
%%%% BOX FOR CONTRIBUTIONS ETC. %%%
%\makeatletter
%\newcommand{\customlabel}[2]{%
%   \protected@write \@auxout {}{\string\newlabel{#2}{{#1}{\thepage}{#1}{#2}{}}}% %regular entry
%   \protected@write \@auxout {}{\string\newlabel{#2@cref}{{[con][][]{{#1}}}{\thepage}}}% %cleveref entry
%   \hypertarget{#2}{}%
%}
%\makeatother
%\newcommand{\header}[4]{\customlabel{#2}{#3}\bigbreak\noindent\textbf{#1:} {\itshape#4}\bigbreak}
