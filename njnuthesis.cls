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

\hyphenation{NjNu-Thesis}
\def\njnuthesis{\textsc{NjNuThesis}}
\def\version{0.1}

% Option switches
\newif\ifnjnu@typeinfo \njnu@typeinfotrue
\DeclareOption{notypeinfo}{\njnu@typeinfofalse}
\newif\ifnjnu@bachelor  \njnu@bachelorfalse
\newif\ifnjnu@master    \njnu@masterfalse
\newif\ifnjnu@doctor    \njnu@doctorfalse

% class options
\DeclareOption{bachelor}{\njnu@bachelortrue}
\DeclareOption{master}{\njnu@mastertrue}
\DeclareOption{doctor}{\njnu@doctortrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions
\LoadClass[cs4size,a4paper,fancyhdr,fntef]{ctexbook}[2005/11/25]
\ifnjnu@bachelor\relax\else
  \ifnjnu@master\relax\else
    \ifnjnu@doctor\relax\else
      \ClassError{njnuthesis}%
                 {You have to specify one of thesis options: bachelor, master or doctor.}{}
    \fi
  \fi
\fi
%% check pdfTeX mode
\RequirePackage{ifpdf,ifxetex}
%% math packages
\RequirePackage{amsmath,amsthm,amsfonts,amssymb,bm}
%% graphics packages
\RequirePackage{graphicx}
\RequirePackage{booktabs} % 三线表
\RequirePackage[sort&compress,numbers]{natbib} % sort and compress citations
% 上标引用
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

\ifxetex
  \RequirePackage[xetex]{hyperref}
  \DeclareGraphicsExtensions{.pdf,.png,.jpg}
\else
  \ifpdf
    \RequirePackage[pdftex]{hyperref}
    \DeclareGraphicsExtensions{.pdf,.png,.jpg}
  \fi
\fi

\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=false}
\fi
\hypersetup{%
   bookmarksnumbered=true,
       bookmarksopen=true,
  bookmarksopenlevel=1,
          breaklinks=true,
          colorlinks=false,
          plainpages=false,
       pdfpagelabels,
           pdfborder=0 0 0}

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

% set font
%\setmainfont[Ligatures=TeX]{Times New Roman}
%\setCJKmainfont{SimSun}
%% 并列子图
\RequirePackage{subfigure}
% ccaption -- bicaption
\RequirePackage{ccaption}
\captiondelim{\ }
\captionnamefont{\kaishu\small}
\captiontitlefont{\kaishu\small}

%  参考文献风格 GBT7714-2005
\bibliographystyle{GBT7714-2005NLang-UTF8}

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

\newcommand\serialnumber[1]{\def\njnu@value@serialnumber{#1}} % 索取号
\newcommand\confidential[1]{\def\njnu@value@confidential{#1}} % 密级
\newcommand\school[1]{\def\njnu@value@school{#1}}
\newcommand\degree[1]{\def\njnu@value@degree{#1}} % 学位级别
\renewcommand\title[2][\njnu@value@title]{
  \def\njnu@value@title{#2}
  \def\njnu@value@titlemark{\MakeUppercase{#1}}} % 标题
\renewcommand\author[1]{\def\njnu@value@author{#1}} % 作者
\newcommand\advisor[1]{\def\njnu@value@advisor{#1}} % 指导教师
\newcommand\institute[1]{\def\njnu@value@institute{#1}} % 培养单位
\newcommand\discipline[1]{\def\njnu@value@discipline{#1}} % 一级学科
\newcommand\subdiscipline[1]{\def\njnu@value@subdiscipline{#1}} % 二级学科
\newcommand\submitdate[1]{\def\njnu@value@submitdate{#1}} % 完成时间
\newcommand\defenddate[1]{\def\njnu@value@defenddate{#1}} % 答辩时间

% 绘制中文标题页
\renewcommand\maketitle{
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
    \bf\songti\zihao{4}
      \njnu@label@serialnumber~
      \njnuunderline[100pt]{\njnu@value@serialnumber} % 索取号
        \hfill
      \njnu@label@confidential~
      \njnuunderline[100pt]{\njnu@value@confidential} % 密级
    \vskip 40pt
      \includegraphics[width=85mm]{njnutitle}
    \vskip \stretch{2}
      \bf\heiti\zihao{-1} \njnu@value@degree\njnu@label@thesis
    \vskip \stretch{2}
      \includegraphics[width=24mm]{njnulogo}
    \vskip \stretch{1}
      \bf\heiti\zihao{-1} \njnu@value@title
    \vskip \stretch{2}
    \begin{tabular}{lc}
      \bf\songti\zihao{4}\njnu@label@author ： &
      \bf\songti\zihao{4}\njnu@value@author
    \\
      \bf\songti\zihao{4}\njnu@label@advisor ： &
      \bf\songti\zihao{4}\njnu@value@advisor
    \\
      \bf\songti\zihao{4}\njnu@label@institute ： &
      \bf\songti\zihao{4}\njnu@value@institute
    \\
      \bf\songti\zihao{4}\njnu@label@discipline ： &
      \bf\songti\zihao{4}\njnu@value@discipline
    \\
      \bf\songti\zihao{4}\njnu@label@subdiscipline ： &
      \bf\songti\zihao{4}\njnu@value@subdiscipline
    \\
      \bf\songti\zihao{4}\njnu@label@submitdate ： &
      \bf\songti\zihao{4}\njnu@value@submitdate
    \\
      \bf\songti\zihao{4}\njnu@label@defenddate ： &
      \bf\songti\zihao{4}\njnu@value@defenddate
    \end{tabular}
  \end{center}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \ifnjnu@typeinfo
      \vspace*{\stretch{1}}
      \begin{footnotesize}
        \noindent
        Typeset by \LaTeXe{} at \CTEX@todayold \\
        With package \texttt{NjNuThesis} \njnufileversion{} of meantobe
      \end{footnotesize}
    \fi
    \cleardoublepage
  \fi
}

% 原创性声明
\newcommand\makeDeclareOriginal{%
  \cleardoublepage
  \thispagestyle{empty}
  \begin{center}
  {\bf\zihao{3} \njnu@value@school}\\
  {\bf\zihao{3} \njnu@label@original}
  \end{center}
  \vskip 10pt
  {\zihao{-4}\njnu@label@originalcontent}
  \vskip 60pt
  \hspace{13em}\njnu@label@authorsign\hrulefill\hspace{1.5em}
  \vskip 15pt
  \hspace{16em}\njnu@label@originalDate\hspace{1em}
  \clearpage
  \if@twoside
    \thispagestyle{empty}
    \cleardoublepage
  \fi
}

% 设置正文页页眉页脚风格
\pagestyle{fancy}
  \fancyhf{}
  \fancyhead[CO,CE]{\small \leftmark}
  \fancyfoot[C]{\small \thepage}
% 设置开章页页眉页脚风格
\fancypagestyle{plain} {
  \fancyhf{}
  \fancyhead[CO,CE]{\small \leftmark}
  \fancyfoot[C]{\small \thepage}
}

\newenvironment{abstract}
  {\Nchapter{\njnu@label@abstract}}
  {}
\newcommand\keywords[1]{%
  \vspace{2ex}\noindent{\heiti \njnu@label@keywords} #1}
\newenvironment{englishabstract}
  {\Nchapter{\njnu@label@englishabstract}}
  {}
\newcommand\englishkeywords[1]{%
  \vspace{2ex}\noindent{\bf \njnu@label@englishkeywords} #1}
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \Nchapter{\contentsname}%
    \@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\addtocontents{toc}{\let\string\CTEX@spaceChar\relax}
\newcommand\Nchapter[1]{%
  \if@mainmatter%
    \@mainmatterfalse%
    \chapter{#1}%
    \@mainmattertrue%
  \else
    \chapter{#1}%
  \fi}
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \leaders\hbox{$\m@th\mkern 1.5mu\cdot\mkern 1.5mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}
\renewcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \setlength\@tempdima{3em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1r
       \leaders\hbox{$\m@th\mkern 1.5mu\cdot\mkern 1.5mu$}
       \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
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
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak
      \leaders\hbox{$\m@th\mkern 1.5mu\cdot\mkern 1.5mu$}
      \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewenvironment{thebibliography}[1]
     {\Nchapter{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newenvironment{publications}[1]
     {\Nchapter{\njnu@label@publications}%
      \@mkboth{\MakeUppercase\njnu@label@publications}
              {\MakeUppercase\njnu@label@publications}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `publications' environment}}%
      \endlist}
\newenvironment{resume}
  {\Nchapter{\njnu@label@resume}}
  {}
\newenvironment{resumesection}[1]
  {{\noindent\normalfont\bfseries #1}
   \list{}{\labelwidth\z@
           \leftmargin 2\ccwd}
   \item\relax}
  {\endlist}
\newenvironment{resumelist}[1]
  {{\noindent\normalfont\bfseries #1}
   \list{}{\labelwidth\z@
           \leftmargin 4\ccwd
           \itemindent -2\ccwd
           \listparindent\itemindent}
   \item\relax}
  {\endlist}
\renewenvironment{thanks}
  {\Nchapter{\njnu@label@thanks}}
  {}

\setcounter{secnumdepth}{4}
\newtheoremstyle{break}% name
  {}%      Space above, empty = `usual value'
  {}%      Space below
  {\itshape}% Body font
  {}%         Indent amount (empty = no indent, \parindent = para indent)
  {\bfseries}% Thm head font
  {.}%        Punctuation after thm head
  {\newline}% Space after thm head: \newline = linebreak
  {}%         Thm head spec
\endinput

%% End of file `njnuthesis.cls'.