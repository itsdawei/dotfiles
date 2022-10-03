\LoadClassWithOptions{article}

% Typesetting and language
\RequirePackage[american]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{charter}
\RequirePackage{enumitem}
\RequirePackage{algpseudocode}

% Symbols
\RequirePackage{amsmath, amsfonts, amsthm, amssymb, mathtools}
\RequirePackage{siunitx}
\RequirePackage[makeroom]{cancel}
\RequirePackage{xfrac}

% Colors & Graphics
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage{tikz}
\RequirePackage[most,many,breakable]{tcolorbox}
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{ulem}
\RequirePackage{multicol,array}
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
	bookmarksopen=true
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

\lstset{
    style              = Matlab-editor,
    basicstyle         = \mlttfamily,
    escapechar         = \~,
    mlshowsectionrules = true,
}

\linespread{1.5}

\pagestyle{fancy}
