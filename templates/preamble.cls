\LoadClassWithOptions{article}

% Typesetting and language
\RequirePackage[american]{babel}
% \RequirePackage[T1]{fontenc}
\RequirePackage[tt=false, type1=true]{libertine}
\RequirePackage{charter}
\RequirePackage{enumitem}
\RequirePackage{algorithm2e}
% \RequirePackage{algpseudocode}
\RequirePackage{csquotes}
\RequirePackage[normalem]{ulem}
\RequirePackage{titlesec}
\RequirePackage{parskip}
\RequirePackage{microtype}

% Symbols
\RequirePackage{amsmath, amsfonts, amsthm, amssymb, mathtools}
\RequirePackage{siunitx}
\RequirePackage[makeroom]{cancel}
\RequirePackage{xfrac}
\RequirePackage[f]{esvect} % vectors

% Colors & Graphics
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{tikz}
\RequirePackage[most,many,breakable]{tcolorbox}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{float}
\RequirePackage{ulem}
% \RequirePackage{multicol, array}
\RequirePackage{listings}
\RequirePackage[numbered]{matlab-prettifier}

% \RequirePackage[object=vectorian]{pgfornament}
% \RequirePackage{wrapfig}
\RequirePackage{varwidth}

\RequirePackage{hyperref,theoremref}
\hypersetup{
	pdftitle={Assignment},
	colorlinks=true,
	bookmarksnumbered=true,
	bookmarksopen=true,
}

% \usepackage{etoolbox}
% %\usepackage{authblk}
% \usepackage[ruled,vlined,linesnumbered]{algorithm2e}
% \usepackage{comment} % enables the use of multi-line comments (\ifx \fi) 
% \usepackage{import}

% \g@addto@macro\bfseries{\boldmath}

\setlength{\parindent}{0pt}

% Define Colors
\definecolor{myblue}{HTML}{0673FF}
\definecolor{exPurple}{HTML}{FF8710}
\definecolor{myremarkpurple}{HTML}{8346FF}

% tcolorbox definitions
\tcbuselibrary{theorems,skins,hooks}

%THEOREM
\newtcbtheorem[number within=section]{theorem}{Theorem}
{%
	enhanced,
	breakable,
	frame hidden,
  interior hidden,
  top = 6mm,
  fonttitle = \bfseries,
	coltitle = black,
  colbacktitle = cyan!15!white,
  colframe = cyan!50!white,
  borderline = {0.5mm}{0mm}{cyan!15!white},
  borderline = {0.5mm}{0mm}{cyan!50!white, dashed},
  attach boxed title to top left = {yshift=-4mm},
  boxed title style = {boxrule=1pt}, 
}{th}

%COROLLARY
\newtcbtheorem[use counter from=theorem]{corollary}{Corollary}
{%
  enhanced,
  breakable,
  frame hidden,
  interior hidden,
  top = 6mm,
  fonttitle = \bfseries,
  coltitle = black,
  colbacktitle = myblue!20!white,
  colframe = myblue!75!white,
  borderline = {0.5mm}{0mm}{myblue!20!white},
  borderline = {0.5mm}{0mm}{myblue!50!white, dashed},
  attach boxed title to top left = {yshift=-4mm},
  boxed title style = {boxrule=1pt},
}{cor}

%LEMMA
\newtcbtheorem[use counter from=theorem]{lemma}{Lemma}
{%
  enhanced,
  breakable,
  frame hidden,
  interior hidden,
  top = 6mm,
  fonttitle = \bfseries,
  coltitle = black,
  colbacktitle = orange!20!white,
  colframe = orange!75!white,
  borderline = {0.5mm}{0mm}{orange!20!white},
  borderline = {0.5mm}{0mm}{orange!50!white,dashed},
  attach boxed title to top left = {yshift=-4mm},
  boxed title style = {boxrule=1pt},
}{lemma}

%REMARK
\newtcbtheorem[no counter]{remark}{Remark}
{%
  detach title, 
  enhanced,
  breakable,
  frame hidden,
  interior hidden,
  fonttitle = \bfseries,
  coltitle = Violet, 
  before upper={\tcbtitle\quad},
  borderline west={0.5mm}{0mm}{myremarkpurple!40!white},
  borderline west={0.5mm}{0mm}{myremarkpurple!60!white, dashed},
}{remark}

%EXAMPLE
\newtcbtheorem[use counter from=theorem]{example}{Example}%
{%
  detach title, 
  enhanced,
  breakable,
  frame hidden, 
  interior hidden, 
  fonttitle = \bfseries, 
  coltitle = black, 
  before upper = {\tcbtitle.\quad},
	borderline = {0.5mm}{0mm}{myremarkpurple!30!white}
}{example}

%PROOF
\renewenvironment{proof}[1][\proofname]{\textbf{\textit{#1.}}}{\qed}
\tcolorboxenvironment{proof}{% `proof' from `amsthm'
  blanker,
  breakable,
  left=5mm,
  before skip=10pt,
  after skip=10pt,
  borderline west={0.5mm}{0pt}{cyan!40},
  borderline west={0.5mm}{0pt}{myremarkpurple!10, dashed},
}

%PROBLEM
\newtcbtheorem[auto counter]{problem}{Problem}
{%
  enhanced,
  breakable,
  frame hidden,
  interior hidden,
  top=6mm,
  fonttitle=\bfseries,
  coltitle=black,
  colbacktitle=cyan!15!white,
  colframe=cyan!50!white,
  borderline={0.5mm}{0mm}{cyan!20!white},
  borderline={0.5mm}{0mm}{cyan!50!white, dashed},
  attach boxed title to top left = {yshift=-4mm},
  boxed title style = {boxrule=1pt}, 
}{prob}
\makeatletter
\newcommand\tcb@cnt@problemautorefname{Problem}
\makeatother

%SOLUTION
\newtcbtheorem[no counter]{solution}{Solution}
{%
  enhanced,
  breakable,
  frame hidden,
  interior hidden,
  top=6mm,
  fonttitle=\bfseries,
  coltitle=black,
  colbacktitle=green!20!white,
  colframe=green!75!white,
  borderline={0.5mm}{0mm}{green!20!white},
  borderline={0.5mm}{0mm}{green!50!white, dashed},
  attach boxed title to top left = {yshift=-4mm},
  boxed title style = {boxrule=1pt},
}{sol}

\newtcbtheorem[auto counter]{definition}{Definition}
{%
  enhanced,
  breakable,
  frame hidden,
  interior hidden,
  top=6mm,
  fonttitle=\bfseries,
  coltitle=black,
  colbacktitle=cyan!15!white,
  colframe=cyan!50!white,
  borderline={0.5mm}{0mm}{cyan!20!white},
  borderline={0.5mm}{0mm}{cyan!50!white, dashed},
  attach boxed title to top left = {yshift=-4mm},
  boxed title style = {boxrule=1pt}, 
}{def}

\newtheorem*{notation}{Notation}
\newtheorem*{note}{Note}
\newtheorem*{observe}{Observe}
\newtheorem*{property}{Property}
\newtheorem*{intuition}{Intuition}
\newtheorem{question}{Question}

\definecolor{backcolor}{rgb}{0.95,0.95,0.92}
\lstset{
    backgroundcolor    = \color{backcolor},   
    style              = Matlab-editor,
    basicstyle         =\linespread{1}\ttfamily,
    escapechar         = \~,
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbersep=5pt,                  
}

\linespread{1.5}

\pagestyle{fancy}
