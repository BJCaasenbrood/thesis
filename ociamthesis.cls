%!TEX root = /home/brandon/Documents/phd/thesis/thesis.tex
% ociamthesis
% 
% Originally by Keith A. Gillow (gillow@maths.ox.ac.uk), 1997
% Modified by Sam Evans (sam@samuelevansresearch.org), 2007
% Modified by John McManigle (john@oxfordechoes.com), 2015
%
% This version Copyright (c) 2015-2017 John McManigle
%
% Broad permissions are granted to use, modify, and distribute this software
% as specified in the MIT License included in this distribution's LICENSE file.
%
%
%-------------------------- identification ---------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ociamthesis}[2015/04/30 Oxford thesis class]
%-------------------------- initial code -----------------------

% JEM: Defaults to one-side, but passing 'twoside' should set everything up for that
\LoadClass[openright,12pt]{report}

\newif\ifmc@nobind
\mc@nobindfalse

\DeclareOption{nobind}{\mc@nobindtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\setlength{\parskip}{0pt plus 1pt}
\setlength{\parfillskip}{0pt plus .7\textwidth}

% JEM: Lengths for single spacing (ie separate abstract, captions), front matter (abstract,
%   acknowledgements, table of contents, etc), and main body text.

\newlength{\singlebaselineskip}
\newlength{\frontmatterbaselineskip}
\newlength{\textbaselineskip}

\setlength{\singlebaselineskip}{\baselineskip}
\setlength{\frontmatterbaselineskip}{17pt plus1pt minus1pt}
\setlength{\textbaselineskip}{22pt plus2pt}

\newcommand{\submittedtext}{{A thesis submitted for the degree of}}
\usepackage{varwidth}
\newcommand{\originalitytext}{%
   \rule[-2mm]{1pt}{7mm}\hspace{-1pt}%
   \rule[-2mm]{7mm}{1pt}\hspace{-1pt}%
   \rule[-2mm]{1pt}{7mm}\hspace{-7mm}%
   \rule[5mm]{7mm}{1pt}\hspace{1em}%
   \begin{varwidth}{\textwidth}I hereby certify that this is entirely\\my own work unless otherwise stated.\end{varwidth}}

\renewcommand{\baselinestretch}{1.2}
\RequirePackage[DIV=11,BCOR=2mm,headinclude=true,footinclude=false]{typearea}
\RequirePackage{pdfpages}
% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the title page and other preamble.

% The year and term the degree will be officially conferred
\def\degreedate#1{\gdef\@degreedate{#1}}
% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}
% The name of your Oxford college (eg Christ Church, Pembroke)
\def\college#1{\gdef\@college{#1}}
% Your candidate number (ie for master's submissions)
\def\candidateno#1{\gdef\@candidateno{#1}}
% Your word count (for master's submissions)
\def\wordcount#1{\gdef\@wordcount{#1}}
\newif\ifmasterssubmission
% adds candidate number and word count in place of name and college
\masterssubmissionfalse

%
% CRESTS
%

\def\crest{{\includegraphics[width = 0.4\textwidth]{fig/logo.pdf}}}
%
% Define text area of page and margin offsets
%

\ifmc@nobind
\usepackage[includehead,hmargin={3.1cm, 3.1cm}, vmargin={2.5cm,2.7cm}, headsep=.8cm,footskip=1.2cm]{geometry}
\else
\usepackage[includehead,hmargin={3.6cm, 2.6cm}, vmargin={2.5cm,2.7cm}, headsep=.8cm,footskip=1.2cm]{geometry}
\fi

\usepackage{xcolor}
\usepackage{graphicx} 

\usepackage{fancyhdr}
\setlength{\headheight}{15pt}
\fancyhf{} % clear the header and footers
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter. #1}{\thechapter. #1}}
\renewcommand{\sectionmark}[1]{\markright{\thesection. #1}} 
\renewcommand{\headrulewidth}{0pt}
\fancyhead[LO]{\emph{\leftmark}} 
\fancyhead[RE]{\emph{\rightmark}} 
\fancyhead[RO,LE]{\emph{\thepage}}

\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\emph{\thepage}}}

% JEM fix header on cleared pages for openright
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
   \hbox{}
   \fancyhead[RE,LO]{}
   \newpage
   \if@twocolumn\hbox{}\newpage
   \fi
   \fancyhead[LO]{\emph{\leftmark}} 
   \fancyhead[RE]{\emph{\rightmark}} 
   \fi\fi}


\usepackage{microtype}
\usepackage{nicefrac}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{textcomp}

\usepackage{longtable} 
	% Allows tables to span multiple pages (this package must be called before hyperref)

\usepackage[font=small,labelfont=bf]{caption} 
	% Nicer captions

\usepackage{multicol,multirow,array} 
	% Used to make multiple columns for the indices and for creating columns that span multiple rows in tables

\usepackage{rotating} 
	% To allow tables in landscape mode

\usepackage{booktabs} 
	% For better looking tables

\usepackage{pdfpages} 
	% Allows multi-page pdfs to be inserted as graphics

\usepackage{xfrac}

%\usepackage{enumerate} 
	% Allows different numbering styles for Lists
	% to use:
	% \begin{enumerate}[x] 
		% \item text 
	% \end{enumerate} 
	% where x is:
	% A	uppercase letters (as produced by \Alph)
	% a	lowercase letters (as produced by \alph)
	% I	uppercase roman numerals (as produced by \Roman)
	% i	lowercase roman numerals (as produced by \roman)
	% 1	arabic numbers (as produced by \arabic)
	
% JEM the following package allows changing spacing in lists (for acknowledgements)
\usepackage{enumitem}

% JEM the following allows table columns aligned by decimal point
\usepackage{dcolumn}
\newcolumntype{d}[3]{D{.}{\cdot}{#1} }

\usepackage{appendix} 
	% For helping format appendicies
\usepackage{notoccite} 
	% To format the bibliography	

\usepackage{mathtools}

\usepackage[colorlinks=false,pdfpagelabels]{hyperref} 
	% for linking between references, figures, TOC, etc in the pdf document

\usepackage[nohints,tight]{minitoc} 
	\setcounter{minitocdepth}{2} 
	% Generates mini tables of contents per chapter
	
% JEM: The following fixes minitoc to not be multiple-spaced.
\let\oldmtc@verse\mtc@verse
\renewcommand{\mtc@verse}[1]{\oldmtc@verse{#1}\setlength{\baselineskip}{\z@}}


%%%%%% EQUATION ALIGNMENT %%%%%%%
\PassOptionsToPackage{fleqn}{amsmath}
% \makeatletter
\newcommand{\ie}{{i.e.}}
\newcommand{\eg}{{e.g.}}

%%%%%%% MATH OPERATORS %%%%%%%
\newcommand{\M}{\mathcal{M}}
\newcommand{\Lg}{\mathcal{V}}
\newcommand{\Hm}{\mathcal{H}}
\newcommand{\La}{\mathcal{L}}
\newcommand{\G}{\mathcal{G}}
\newcommand{\g}{\mathfrak{g}}
\newcommand{\V}{\mathcal{V}}
\newcommand{\T}{\mathcal{T}}
\newcommand{\Ts}{\mathbb{T}}
\newcommand{\Xs}{\mathbb{X}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\R}{\mathbb{R}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\I}{\mathbb{I}}
\newcommand{\op}{\,{\circ}\,}
\newcommand{\q}{\boldsymbol{q}}
\newcommand{\Ph}{\mathbb{E}}
\newcommand{\tr}{\top}
\newcommand{\ad}{\text{ad}}
\newcommand{\Ad}{\text{Ad}}
\newcommand{\p}{\partial}
\newcommand{\rank}{\textnormal{rank}}
\newcommand{\col}{\textnormal{col}}
\newcommand{\row}{\textnormal{row}}
\newcommand{\pinv}{+}
\newcommand{\ginv}{{g} }
\newcommand{\pinvt}{{+\top} }
\newcommand{\Span}{\textnormal{span}}
\newcommand{\argmin}{\textnormal{argmin}}

\newcommand{\inv}{^{\raisebox{.2ex}{$\scriptscriptstyle-1$}}}

% \DeclarePairedDelimiterX{\infdivx}[2]{(}{)}{%
%   #1\;\delimsize\|\;#2%
% }
% \newcommand{\infdiv}{D\infdivx}
% \DeclarePairedDelimiterX{\norm}[1]{\lVert}{\rVert}{#1}
% \DeclarePairedDelimiterX{\norms}[1]{\lVert}{\rVert^2}{#1}
% \DeclarePairedDelimiterX{\bk}[1]{(}{)}{#1}

\DeclareMathOperator{\sech}{sech}
\DeclareMathOperator{\csch}{csch}
\DeclareMathOperator{\Rp}{\R_{\ge 0}}
\DeclareMathOperator{\Rsp}{\R_{>0}}
\newcommand{\Rot}[1]{^{#1}\boldsymbol{\Phi}}
\renewcommand{\vec}[1]{{#1}}
\newcommand{\mat}[1]{{#1}}
\newcommand{\se}[1]{{\mathfrak{se}(#1)}}
\newcommand{\cose}[1]{{\mathfrak{se}^*(#1)}}
\newcommand{\sog}[1]{{\mathfrak{so}(2)}}
\newcommand{\SO}[1]{{\mathbb{SO}(#1)}}
\newcommand{\SE}[1]{{\mathbb{SE}(#1)}}
\newcommand{\Id}[1]{{\mathbb{I}^#1}}
%\newcommand{\mat}[1]{\boldsymbol{#1}}
%\renewcommand{\vec}[1]{\boldsymbol{#1}}
%\newcommand{\Rotlin}[1]{^{#1}\hat{\boldsymbol{\Phi}}
\newcommand{\base}[2]{^{#1}{#2}}
\newcommand{\blkdiag}[1]{\textnormal{blkdiag}\left\{ {#1} \right\}}

%%%%%%% FIGURE SIZES %%%%%%%
\newcommand*{\smallfig}{0.5\textwidth}
\newcommand*{\normfig}{0.75\textwidth}
\newcommand*{\bigfig}{.95\textwidth}

 %%%%%%% MATH OPERATORS %%%%%%%
 \theoremstyle{definition}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{corollary}{Corollary}[chapter]
\newtheorem{lemma}{Lemma}[chapter]
\newtheorem{intermezzo}{Intermezzo}[chapter]
\newtheorem{definition}{Definition}[chapter]
\newtheorem{example}{Example}[chapter]
\newtheorem{property}{Property}[chapter]
\theoremstyle{definition}

%
% Environments
%

% This macro define an environment for front matter that is always 
% single column even in a double-column document.

\newenvironment{alwayssingle}{%
       \@restonecolfalse
       \if@twocolumn\@restonecoltrue\onecolumn
       \else\if@openright\cleardoublepage\else\clearpage\fi
       \fi}%
       {\if@restonecol\twocolumn
       \else\newpage\thispagestyle{empty}\fi}


%define title page layout

\renewcommand{\maketitle}{%
\begin{alwayssingle}\null
    \renewcommand{\footnotesize}{\small}
    \renewcommand{\footnoterule}{\relax}
    \thispagestyle{empty}
\ifmasterssubmission
  \begin{center}
  \vspace*{-3ex}
    { \LARGE {\bfseries {\@title}} \par}
{\large \vspace*{25mm} {\crest \par} \vspace*{20mm}}
    {{\Large Candidate no.\ \@candidateno} \par}
{\large \vspace*{1ex}
    {Word count: {\@wordcount} \par}
\vspace*{4ex}
    {{\submittedtext} \par}
\vspace*{1ex}
    {\it {\@degree} \par}
\vspace*{6ex}
	{{\originalitytext} \par}
\vspace*{2ex}
    {\@degreedate}}
  \end{center}
\else
  \begin{center}
    { \LARGE {\bfseries {\@title}} \par}
{\large \vspace*{30mm} {\crest \par} \vspace*{25mm}}
    {{\Large \@author} \par}
{\large \vspace*{1ex}
    {{\@college} \par}
\vspace*{1ex}
    {Technical University of Eindhoven \par}
\vspace*{20mm}
    {{\submittedtext} \par}
\vspace*{1ex}
    {\it {\@degree} \par}
\vspace*{2ex}
    {\@degreedate}}
  \end{center}
\fi
  \vfill\null
\end{alwayssingle}}



% DEDICATION
%
% The dedication environment makes sure the dedication gets its
% own page and is set out in verse format.

\newenvironment{dedication}
{\begin{alwayssingle}
  \thispagestyle{empty}
  \vspace*{\fill} \begin{center}}
{\end{center}\vspace*{\fill}\vspace*{\fill} \end{alwayssingle}}


% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page. The acknowledgements
% themselves appear in a quote environment, i.e. tabbed in at both sides, and
% on its own page.

\newenvironment{acknowledgements}%
{   \begin{alwayssingle}\chapter*{Acknowledgements}
    \thispagestyle{empty}
	\pagestyle{empty}
	\setlength{\baselineskip}{\frontmatterbaselineskip}
}
{\end{alwayssingle}}


%ABSTRACT
%
%The abstract environment puts a large, bold, centered "Abstract" label at
%the top of the page. The abstract itself appears in a quote environment,
%i.e. tabbed in at both sides, and on its own page.

\renewenvironment{abstract}%
{   \begin{alwayssingle}\chapter*{Abstract}
    \thispagestyle{empty}
    \pagestyle{empty}
   \setlength{\baselineskip}{\frontmatterbaselineskip}}
{\end{alwayssingle}}

%The abstractseparate environment is for running of a page with the abstract
%on including title and author etc as required to be handed in separately

\newenvironment{abstractseparate} {\newgeometry{margin=3.3cm}\thispagestyle{empty}\begin{alwayssingle}
 \begin{center}
    {\Large \bfseries \@title \par}
\ifmasterssubmission
    {{\large \vspace*{3ex} Candidate no.\ \@candidateno} \par}
\else
    {{\large \vspace*{2ex} \@author} \par}
\fi
{\large \vspace*{1ex}
\ifmasterssubmission
    {Thesis word count: {\@wordcount} \par}
\else
    {{\@college} \par}
    {Technical University of Eindhoven \par}
\fi
\vspace*{1ex}
    {{\it \submittedtext} \par}
    {\it {\@degree} \par}
\vspace*{2ex}
    {\@degreedate} \par}
\vfill
  {\Large \bfseries  Abstract}
  \end{center}
\vspace{1ex}
   \setlength{\baselineskip}{\z@}}
{\vfill\end{alwayssingle}\restoregeometry}


%ROMANPAGES
%
% The romanpages environment set the page numbering to lowercase roman one
% for the contents and figures lists. It also resets
% page-numbering for the remainder of the dissertation (arabic, starting at 1).
%
% Edited by JEM

\newenvironment{romanpages}
{\cleardoublepage\setlength{\baselineskip}{\frontmatterbaselineskip}\setcounter{page}{1}\renewcommand{\thepage}{\roman{page}}}
{\cleardoublepage\setcounter{page}{1}\renewcommand{\thepage}{\arabic{page}}}


%Figure placement on page
%
%This is to help prevent too many figures on their own pages.  I got it from:
% http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/LatexTips.html#captfont

\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}


% JEM: VERSE, QUOTATION, and QUOTE must be single-spaced.
% These rename the internal commands for the \begin{...} and
% \end{...} environment commands.
\let\@ldquote=\quote
\let\@ldendquote=\endquote
\renewenvironment{quote}
   {\@ldquote\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendquote}

\let\@ldqttn=\quotation
\let\@ldendqttn=\endquotation
\renewenvironment{quotation}
   {\@ldqttn\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendqttn}

\let\@ldverse=\verse
\let\@ldendverse=\endverse
\renewenvironment{verse}
   {\@ldverse\setlength{\baselineskip}{\singlebaselineskip}}
   {\@ldendverse}

% JEM: Stuff for List of Abbreviations (or Glossary or other list)
\usepackage{calc}
\newcommand{\t@cfill}{\cleaders\hbox{$\m@th \mkern\@dotsep mu . \mkern\@dotsep mu$}\hfill}
\newcommand{\abbrl@bel}[1]{\makebox[\labelwidth][l]{\textbf{#1}\ \t@cfill}}
\newenvironment{mclistof}[2]{%
   \chapter*{#1}%
   \addcontentsline{toc}{chapter}{#1}
   \begin{list}{}%
   {\renewcommand{\makelabel}{\abbrl@bel}%
    \setlength{\labelwidth}{#2}%
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\itemsep}{0pt}%
    \markboth{#1}{#1}%
   }}
   {\end{list}\mtcaddchapter}


\usepackage[grey,utopia]{quotchap} 
	% To put nice quotes at the beginning of the chapters

\usepackage[nottoc]{tocbibind}
	% Used for inserting the Bibliography, List of Figures, indices, etc into the table of contents.

% JEM: Allow flexible spacing after figures, to reduce other stretching
\setlength{\textfloatsep}{20pt plus15pt minus4pt}

% JEM: Fix paragraph spacing within quotes for multi-par quotes
\renewenvironment{savequote}[1][10cm]{%
\begin{lrbox}{\@quotebox}
\begin{minipage}[t]{#1}\footnotesize\slshape%
\setlength{\parskip}{6px}}{%
\unskip\end{minipage}\end{lrbox}
\global\setbox\@quotebox\copy\@quotebox
\global\let\@printcites\@iprintcites
\ignorespacesafterend}
\renewcommand{\qauthor}[1]{\par
{\raggedleft\upshape #1\qquad\hbox{}\par}\bigskip}

% JEM: All of this is so that headers in these sections aren't uppercase
\let\@ldtoc\tableofcontents
\renewcommand*\tableofcontents{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldtoc}}
\let\@ldlof\listoffigures
\renewcommand*\listoffigures{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlof}}
\let\@ldlot\listoftables
\renewcommand*\listoftables{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldlot}}
\let\@ldbib\bibliography
\renewcommand*\bibliography[1]{{%
\renewcommand*\MakeUppercase[1]{##1}\@ldbib{#1}}}

% JEM: for crazy multi character set quotes and Unicode and all
\usepackage{lmodern}
%\usepackage[LGR,TS1,T1]{fontenc}
\usepackage[utf8]{inputenc}
%\usepackage[greek,latin,english]{babel}
\usepackage{csquotes}
\hyphenpenalty=500
\def\longs{{\fontencoding{TS1}\selectfont s}}

% JEM: for highlighting corrections
\newlength{\mccurrentbaselineskip}
\newlength{\mccurrentparskip}
\newlength{\mccurrentparindent}
\newif\ifcorrections
\newif\ifm@csection
\m@csectionfalse
\correctionsfalse


\definecolor{pyblue}{rgb}{0.12,0.466,0.705}
%\definecolor{tuewarmred}{cmyk}{0,1,0.9,0}%PMS Warm Red; RGB 247,49,49
%\definecolor{tuecyan}{cmyk}{1,0,0,0}%PMS Process Cyan; RGB 0,162,222
%\definecolor{tuered}{cmyk}{0,1,0.5,0}%PMS 206; RGB 214,0,74
%\definecolor{tueblue}{cmyk}{1,0.5,0,0}%PMS 300; RGB 0,102,204
%\definecolor{tuedarkblue}{cmyk}{1,0.8,0,0.2}%PMS 2748; RGB 16,16,115
%\definecolor{tueorange}{cmyk}{0,0.5,1,0}%PMS 137; RGB 255,154,0
%\definecolor{tueyellow}{cmyk}{0,0.1,1,0}%PMS Yellow 012; RGB 255,221,0
%\definecolor{tuelightgreen}{cmyk}{0.55,0,1,0}%PMS 375; RGB 132,210,0
%\definecolor{tuegreen}{cmyk}{1,0,0.6,0}%PMS Green; RGB 0,172,130

\colorlet{shadecolor}{pyblue!0}

\usepackage{framed}
\OuterFrameSep=-3pt
\newenvironment{define}[1]
{\ifcorrections\if@nobreak\m@csectiontrue\fi\vspace{2mm}\begin{shaded}\vspace{-5mm}\ifm@csection\noindent\ignorespaces\fi\fi \begin{definition}[#1]}
{\ifcorrections\end{definition}\vspace{-5mm}\end{shaded}\vspace{2mm}\m@csectionfalse\ifx\@captype\@undefined\@nobreakfalse\fi\fi}

\newenvironment{examp}[1]
{\ifcorrections\if@nobreak\m@csectiontrue\fi\vspace{2mm}\begin{shaded}\vspace{-5mm}\ifm@csection\noindent\ignorespaces\fi\fi \begin{example}[#1]}
{\ifcorrections\end{example}\vspace{-5mm}\end{shaded}\vspace{2mm}\m@csectionfalse\ifx\@captype\@undefined\@nobreakfalse\fi\fi}

\newenvironment{prop}[1]
{\ifcorrections\if@nobreak\m@csectiontrue\fi\vspace{2mm}\begin{shaded}\vspace{-5mm}\ifm@csection\noindent\ignorespaces\fi\fi \begin{property}[#1]}
{\ifcorrections\end{property}\vspace{-5mm}\end{shaded}\vspace{2mm}\m@csectionfalse\ifx\@captype\@undefined\@nobreakfalse\fi\fi}


\usepackage{soul}
\sethlcolor{shadecolor}
\newcommand{\mccorrect}[1]{\ifcorrections\hl{#1}\else#1\fi}

%\RequirePackage[final,bookmarks]{hyperref}
\hypersetup{
    pdftitle={PHD THESIS},
    colorlinks= true,
    linkcolor={blue},
    citecolor={blue},
    urlcolor={green!50!black}}

% JEM: adjust start-of-chapter spacing
\renewcommand{\chapterheadstartvskip}{\vspace*{-80pt}}
\renewcommand{\chapterheadendvskip}{\vspace{20pt}}

% JEM: combine all of the commands you run before appendices start
\newcommand{\startappendices}
  {\appendix\adjustmtc\noappendicestocpagenum\addappheadtotoc\appendixpage}

\usepackage{listings}
%% code styles
\lstdefinestyle{defaultStyle}
{
  basicstyle=\footnotesize,
  tabsize=2,
  captionpos=b,
  frame=lines,
  breaklines=true,
  keepspaces=true
}
% define C++ style
\usepackage{listings}

\colorlet{mygray}{black!30}
\colorlet{mygreen}{green!50!blue}
\colorlet{mymauve}{red!60!blue}

\lstset{
  backgroundcolor=\color{gray!20},  
  basicstyle=\ttfamily,
  columns=fullflexible,
  breakatwhitespace=false,      
  breaklines=true,                
  captionpos=b,                    
  commentstyle=\color{mygreen}, 
  extendedchars=true,              
  frame=single,                   
  keepspaces=true,             
  keywordstyle=\color{blue},      
  language=c++,                 
  numbers=none,                
  numbersep=5pt,                   
  numberstyle=\tiny\color{blue}, 
  rulecolor=\color{gray!20},        
  showspaces=false,               
  showtabs=false,                 
  stepnumber=5,                  
  stringstyle=\color{mymauve},    
  tabsize=3,                      
  title=\lstname                
}