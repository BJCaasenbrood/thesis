%
% CLASS FOR PHD THESIS
%
% This file uses the standard report class
%
% Options: - draft or final
%            draft: B5 centered on A4 paper, including crossmarks
%            final: B5 paper
%          - thumbmain or thumbfull (or no thumb index)
%            thumbmain: adds a thumb index to the main matter only, i.e. to numbered chapters/appendices
%            thumbfull: adds a thumb index to all chapters, i.e. \chapter{} and \chapter*{}
%          - print: adds 3 mm bleed to the B5 paper
% Version: 09-Feb-2021, Mark Rijnen
% Adopted from: 26-Nov-2018, Mark Rijnen (MR)
% Based on class by Bart Besselink (BART), Benjamin Biemond (BB)

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
%\ProvidesClass{mrthesis}[2018/11/26 PhD thesis class - Mark Rijnen]
\ProvidesClass{thesis}[2021/02/09 PhD thesis class - Brandon Caasenbrood (adopted from Mark Rijnen)]

%%% COLOR/STYLE OF THESIS %%%
\RequirePackage{xcolor}

%%% PROCESS OPTIONS %%%
% set boolean: draft or final
\newif\ifmrdraft\mrdraftfalse   % draft, standard false (i.e. final)
\newif\ifthumb\thumbfalse       % thumb index, standard false (i.e. no index)
\newif\ifthumbpre\thumbprefalse % thumb index for front matter, standard false
\newif\ifprint\printfalse       % include a 3mm bleed to the pages for printing

% declare options
\DeclareOption{draft}{\mrdrafttrue}
\DeclareOption{final}{\mrdraftfalse}
\DeclareOption{thumbmain}{\thumbtrue}
\DeclareOption{thumbfull}{\thumbtrue\thumbpretrue}
\DeclareOption{print}{\printtrue}

% process options
\ProcessOptions\relax

%%% LOAD REPORT CLASS %%%
\LoadClass[10pt,openright,twoside]{report}

%%% USE GEOMETRY PACKAGE TO SET PAPER SIZE %%%
% set options for geometry package
\edef\geometryoptions{[twoside%
\ifmrdraft
    ,driver=none
  \fi]}

% load geometry package
\expandafter\RequirePackage\geometryoptions{geometry}
\ifprint % add 3mm bleed to the pages and move text slightly away from spine for legibility
\geometry{
    paperwidth  = 176mm,
    paperheight = 246mm,
    top         =  35mm,
    bottom      =  28mm,
    inner       =  28mm,
    outer       =  23mm,
    headsep     =   7mm,
    headheight  =  14pt,
}
\else
\geometry{
    paperwidth  = 170mm,
    paperheight = 240mm,
    top         =  32mm,
    bottom      =  25mm,
    inner       =  22.5mm,
    outer       =  22.5mm,
    headsep     =   7mm,
    headheight  =  14pt,
}
\fi

%%% USE CROP PACKAGE FOR DRAFT VERSION %%%
\ifmrdraft
    \RequirePackage[frame,a4,center]{crop}
\fi

%%% THUMB INDEX DEFINITIONS %%%

\RequirePackage{tikz}
\usetikzlibrary{calc}

\newcounter{letternum}              % chapter counter
\newlength{\thumbheight}            % height of the thumb index tags
\newlength{\thumbtopmargin}         % margin between top of page and first thumb index tag
\newlength{\thumbsep}               % separation between edge of page and start of semi-circle
\ifprint
\setlength{\thumbsep}{7mm}          % add 3 mm for bleed
\setlength{\thumbheight}{1.467cm}
\setlength{\thumbtopmargin}{1.3cm}
\else
\setlength{\thumbsep}{4mm}
\setlength{\thumbheight}{1.586cm}
\setlength{\thumbtopmargin}{0.9cm}
\fi
\newcommand{\thumbeven}[1]{
    \begin{tikzpicture}[remember picture, overlay]
            \fill[thumbcolor] ($%
            (current page.north west)-%
            (0,{\thumbtopmargin+(\value{letternum}-1)*\thumbheight})$) -- ++ (\thumbsep,0) arc (90:-90:0.5*\thumbheight) -- ++(-\thumbsep,0);
            \node[text=white,font=\sffamily\bfseries] at ($%
                (current page.north west)-%
                (-0.15*\thumbheight-\thumbsep,{\thumbtopmargin+(\value{letternum}-0.5)*\thumbheight})%
                $) {#1};
    \end{tikzpicture}}
\newcommand{\thumbodd}[1]{
    \begin{tikzpicture}[remember picture, overlay]
            \fill[thumbcolor] ($%
            (current page.north east)-%
            (0,{\thumbtopmargin+(\value{letternum}-1)*\thumbheight})$) -- ++ (-\thumbsep,0) arc (90:270:0.5*\thumbheight) -- ++(\thumbsep,0);
            \node[text=white,font=\sffamily\bfseries] at ($%
                (current page.north east)-%
                (0.15*\thumbheight+\thumbsep,{\thumbtopmargin+(\value{letternum}-0.5)*\thumbheight})%
                $) {#1};
    \end{tikzpicture}}

\newif\ifisstarredchapter\isstarredchaptertrue
\newcommand{\evenpageletterthumb}[1]{%
     \ifisstarredchapter
        \ifthumbpre
            \thumbeven{}
        \fi
     \else
        \thumbeven{#1}
     \fi
}
\newcommand{\oddpageletterthumb}[1]{%
     \ifisstarredchapter
        \ifthumbpre
            \thumbodd{}
        \fi
     \else
        \thumbodd{#1}
     \fi
}

%%% DEFINE HEADERS %%%
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\apptocmd{\@chapter}{\ifthumb\stepcounter{letternum}\fi}{}{}
\apptocmd{\@schapter}{\ifthumb\ifthumbpre\stepcounter{letternum}\fi\fi}{}{}

% set headers and footers
\pagestyle{fancy}
\fancyhf{}
\fancyhead[RO,LE]{\thepage}
\ifthumb
    \fancyhead[LO]{\slshape\nouppercase\rightmark\oddpageletterthumb{\thechapter}}
    \fancyhead[RE]{\slshape\nouppercase\leftmark\evenpageletterthumb{\thechapter}}
\else
    \fancyhead[LO]{\slshape\nouppercase\rightmark}
    \fancyhead[RE]{\slshape\nouppercase\leftmark}
\fi

% remove page number on plain pages
\fancypagestyle{plain}{%
  \fancyhead{}
  \fancyfoot{}
  \renewcommand{\headrulewidth}{0pt}
}%

%%%% MAKE SURE THAT EMPTY PAGES BEFORE A NEW CHAPTER ARE REALLY EMPTY %%%
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace{\fill}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}

%%% DEFINE CHAPTER LAYOUT %%%
\RequirePackage[T1]{fontenc}
\RequirePackage{titlesec}
\def\@chapnumfont{%             % define font for chapter number
  \usefont{T1}{pnc}{b}{n}%      % choose New Chancery, bold, normal shape
  \fontsize{90}{100}%           % font size 90pt, baselineskip 100pt
  \selectfont%                  % activate font
}
\def\@partnumfont{%             % define font for part number
  \usefont{T1}{pnc}{m}{n}%      % choose New Chancery, normal, normal shape
  \fontsize{40}{40}%            % font size 40pt, baselineskip 40pt
  \selectfont%                  % activate font
}

\titleformat{\chapter}[display]
{\filleft\bfseries}
{\filleft\vspace*{-5mm}\@chapnumfont\textcolor{titlecolor}{\thechapter}} % Add negative vspace to move header higher on the page
{-24pt}
{\Huge\textcolor{titlecolor}}

\titleformat{\part}[display]
{\centering\bfseries}
{\@partnumfont\textcolor{titlecolor}{\thepart}}
{24pt}
{\Huge\textcolor{titlecolor}}

%%% CHANGE FORMAT FIGURE CAPTIONS %%%
\RequirePackage[format=plain,labelsep=period,labelfont=bf]{caption}


%%% MACROS AND NEW COMMANDS %%%
\newcommand{\chapterabstract}[1]{\noindent{\bf Abstract -}\ {\small{#1}} \normalsize \vfill}
