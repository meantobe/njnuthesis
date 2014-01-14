% meantobe <meantobe@msn.com>
% njnuthesis.cls
% Copyright 2014, meantobe (Gao Longjie)
% https://github.com/meantobe/njnuthesis
% 
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{njnuthesis}
[2014/01/14 v0.1 Nanjing Normal University Thesis Template]

\def\njnuthesis{\textsc{NjNuThesis}}
\def\version{0.1}

% Option switches
\newif\ifnjnu@bachelor  \njnu@bachelorfalse
\newif\ifnjnu@master    \njnu@masterfalse
\newif\ifnjnu@doctor    \njnu@doctorfalse

% class options
\DeclareOption{bachelor}    {\njnu@bachelortrue}
\DeclareOption{master}      {\njnu@mastertrue}
\DeclareOption{doctor}      {\njnu@doctortrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions
\LoadClass[cs4size,a4paper,fancyhdr,fntef]{ctexbook}[2005/11/25]
%% check pdfTeX mode
\RequirePackage{ifpdf,ifxetex}
%% math packages
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm}
%% graphics packages
\RequirePackage{graphicx}
%% sort and compress citations
\RequirePackage[sort&compress,numbers]{natbib}
% 上标引用
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}
%% packages and settings depend on PDF mode
\ifxetex
  \RequirePackage[xetex]{hyperref}
  \DeclareGraphicsExtensions{.pdf,.png,.jpg}
\fi
\hypersetup{CJKbookmarks,%
       bookmarksnumbered,%
              colorlinks,%
               linkcolor=blue,%
               citecolor=blue,%
              plainpages=false,%
            pdfstartview=FitH}
\AtEndOfPackage{\makeatletter\input{njnuthesis.cfg}\makeatother}
%% 页边距设置
\oddsidemargin 0.5 true cm
\if@twoside
  \evensidemargin 0 true cm
\else
  \evensidemargin 0.5 true cm
\fi
\textheight 24.2 true cm
\textwidth 15.5 true cm
\headheight 15pt
\parskip 0.5ex plus 0.25ex minus 0.25ex
%% 上边距
\addtolength{\voffset}{-1.5cm}

%% Command -- Clear Double Page
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \thispagestyle{empty}%
  \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

\newcommand\njnuspace{\protect\CTEX@spaceChar\protect\CTEX@spaceChar}

\def\njnu@getfileinfo#1 #2 #3\relax#4\relax{%
  \def\njnufiledate{#1}%
  \def\njnufileversion{#2}%
  \def\njnufileinfo{#3}}%
\expandafter\ifx\csname ver@njnuthesis.cls\endcsname\relax
  \edef\reserved@a{\csname ver@ctextemp_njnuthesis.cls\endcsname}
\else
  \edef\reserved@a{\csname ver@njnuthesis.cls\endcsname}
\fi
\expandafter\njnu@getfileinfo\reserved@a\relax? ? \relax\relax

\def\njnu@underline[#1]#2{%
  \CTEXunderline{\hbox to #1{\hfill#2\hfill}}}
\def\njnuunderline{\@ifnextchar[\njnu@underline\CTEXunderline}

\newcommand\classification[1]{\def\njnu@value@classification{#1}}
\newcommand\confidential[1]{\def\njnu@value@confidential{#1}}
\newcommand\UDC[1]{\def\njnu@value@UDC{#1}}
\newcommand\serialnumber[1]{\def\njnu@value@serialnumber{#1}}
\newcommand\school[1]{\def\njnu@value@school{#1}}
\newcommand\degree[1]{\def\njnu@value@degree{#1}}
\renewcommand\title[2][\njnu@value@title]{
  \def\njnu@value@title{#2}
  \def\njnu@value@titlemark{\MakeUppercase{#1}}}
\renewcommand\author[1]{\def\njnu@value@author{#1}}
\newcommand\advisor[1]{\def\njnu@value@advisor{#1}}
\newcommand\advisorinstitute[1]{\def\njnu@value@advisorinstitute{#1}}
\newcommand\major[1]{\def\njnu@value@major{#1}}
\newcommand\submitdate[1]{\def\njnu@value@submitdate{#1}}
\newcommand\defenddate[1]{\def\njnu@value@defenddate{#1}}
\newcommand\institute[1]{\def\njnu@value@institute{#1}}
\newcommand\chairman[1]{\def\njnu@value@chairman{#1}}

% 绘制中文标题页
\renewcommand\maketitle{%
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \bf\songti\zihao{-4}
      \njnu@label@classification~
      \njnuunderline[100pt]{\njnu@value@classification}
        \hfill
      \njnu@label@confidential~
      \njnuunderline[100pt]{\njnu@value@confidential}
    \vskip 10pt
      \njnu@label@UDC~
      \njnuunderline[108pt]{\njnu@value@UDC}
        \hfill
      \njnu@label@serialnumber~
      \njnuunderline[100pt]{\njnu@value@serialnumber}
    \vskip \stretch{2}
      \bf\songti\zihao{-1} \njnu@value@school \\
      \njnu@value@degree
  \end{center}
  \clearpage
}

%% 复杂表格
\RequirePackage{threeparttable}
\RequirePackage{dcolumn}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\newcolumntype{d}[1]{D{.}{.}{#1}}% or D{.}{,}{#1} or D{.}{\cdot}{#1}

\ifnjnu@bachelor\relax\else
  \ifnjnu@master\relax\else
    \ifnjnu@doctor\relax\else
      \ClassError{njnuthesis}%
                 {You have to specify one of thesis options: bachelor, master or doctor.}{}
    \fi
  \fi
\fi

% set font
\setmainfont[Ligatures=TeX]{Times New Roman}
\setCJKmainfont{SimSun}

%% graphics packages
\RequirePackage{graphicx}
%% 并列子图
\RequirePackage{subfigure}
% ccaption -- bicaption
\RequirePackage{ccaption}
\captiondelim{\ }
\captionnamefont{\kaishu\small}
\captiontitlefont{\kaishu\small}

%  参考文献风格 GBT7714-2005
\bibliographystyle{GBT7714-2005NLang-UTF8}

% 设置正文页页眉页脚风格
\pagestyle{fancy}
  \fancyhf{}
  \fancyhead[CO,CE]{\small \leftmark}
  \fancyfoot[C]{\small \thepage} %页脚格式
% 设置开章页页眉页脚风格
\fancypagestyle{plain} {
  \fancyhf{}
  \fancyhead[CO,CE]{\small \leftmark}
  \fancyfoot[C]{\small \thepage} %页脚格式
}

\endinput

%% End of file `njnuthesis.cls'.