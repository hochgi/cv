%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CV
% LaTeX Class
%
% Adapted from Spider CV v1.1 (08/10/22) by ROMAINPC,
% with the spider chart and other unused widgets removed.
%
% A4 layout: the text flows normally over framed pages, opened by a filled top
% bar on page 1 and closed by a matching footer bar on the last page.
%
% Spider CV was:
% Inspired by developercv (Jan Vorisek)
% Inspired by developercv Doji variant (Stijn Dejongh)
% Inspired by limecv (Olivier Pieters)
% Inspired by altacv (LianTze Lim)
%
% License:
% The MIT License
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{extarticle} % Load the base class

%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------

\setlength{\parindent}{0mm} % Suppress paragraph indentation
\usepackage[hidelinks]{hyperref} % Required for links but hide the default boxes around links
\pagestyle{empty} % No headers or footers
\usepackage{moresize} % Provides more font size commands (\HUGE and \ssmall)
\usepackage{fontawesome} % fontawesome

%----------------------------------------------------------------------------------------
%	COLORS
%----------------------------------------------------------------------------------------
\usepackage[dvipsnames]{xcolor}

\definecolor{DarkGrey}{HTML}{2B2B2B}
\definecolor{LightGrey}{HTML}{EFEFEF}
\definecolor{MidGrey}{HTML}{A0A0A0}
\definecolor{VeryLightOrange}{HTML}{FFFCE8}
\definecolor{MainGrey}{HTML}{333333}
\definecolor{MainOrange}{HTML}{FF8000}
\definecolor{SecondaryOrange}{HTML}{FFB01C}
\definecolor{LinkCyan}{HTML}{40C0E0}
\definecolor{Gareyish}{HTML}{506266} 


%%%%% color macros, use it at the beginning of your cv to quickly use the enterprise colors (Pro HRD tips)
\newcommand{\DefineColorMacros}[5]{% COLORS : TextSide / TextMain / HighLight / Background /Other
    \def\ColorTextSide{#1}
    \def\ColorTextMain{#2}
    \def\ColorHighlight{#3}
    \def\ColorBackground{#4}
    \def\ColorOther{#5}
    \color{\ColorTextMain} % Default text color
}

\DefineColorMacros{MainGrey}{DarkGrey}{Gareyish}{SecondaryOrange}{LinkCyan}



%----------------------------------------------------------------------------------------
%	Printable mode
%----------------------------------------------------------------------------------------
\newcommand{\PrintableMode}{
    \def\PM{} % PM command used in if statements
    \def\ColorTextSide{\ColorTextMain} % Use same text color everywhere
}


%----------------------------------------------------------------------------------------
%	FONTS
%----------------------------------------------------------------------------------------

\usepackage[utf8]{inputenc} % Required for inputting international characters
\usepackage[T1]{fontenc} % Output font encoding for international characters

% \usepackage{roboto}
\usepackage[scaled]{helvet}


% \renewcommand*\familydefault{\sfdefault} % Force the sans-serif version of any font used



%----------------------------------------------------------------------------------------
%	GEOMETRIE
%----------------------------------------------------------------------------------------
\usepackage{calc}
\usepackage{tikz}
\usetikzlibrary{calc,positioning,backgrounds,matrix}

\newlength\margin
\setlength\margin{0.15cm}
\newlength\anglesize
\setlength\anglesize{0.25cm}
\newlength\pagemargin
\setlength\pagemargin{5\margin}

% Heights of the top bar (page 1: name, about, contact) and the footer bar
% (last page: blog, talks, open source). Tune when their content changes.
\newlength\topbarheight
\setlength\topbarheight{5.6cm}
\newlength\footbarheight
\setlength\footbarheight{4.2cm}
\newlength\footbarpad
\setlength\footbarpad{0.25cm}

\usepackage[a4paper, margin=\pagemargin, noheadfoot]{geometry}

% Where the bands end, measured from the top / bottom paper edge.
\newlength\topbandbottom
\setlength\topbandbottom{\pagemargin+\topbarheight+2\margin}
\newlength\footbandtop
\setlength\footbandtop{0.5\margin+\footbarheight+2\footbarpad}

%----------------------------------------------------------------------------------------
%	MAIN SECTIONS
%----------------------------------------------------------------------------------------
% The text flows normally over the pages. Behind it, every page gets a frame
% with angled corners; page 1 also gets the filled top bar, and the last page
% the filled footer bar.

\usepackage{ragged2e}
\usetikzlibrary{shapes,decorations}

% Page that holds the footer bar, recorded by FooterBar in the previous LaTeX
% pass (build.sh runs two passes).
\providecommand{\cvlastpage}{0}

\newlength\frametop
\newlength\framebottom
\AddToHook{shipout/background}{%
    \ifnum\value{page}=1 \setlength\frametop{\topbandbottom+\margin}\else\setlength\frametop{0.5\margin}\fi
    \ifnum\value{page}=\cvlastpage\relax \setlength\framebottom{\footbandtop+\margin}\else\setlength\framebottom{0.5\margin}\fi
    \put(0,0){\begin{tikzpicture}[overlay]
        % main frame
        \draw[draw=\ColorBackground, very thick]
            (0.5\margin+\anglesize,-\frametop) --
            (\paperwidth-0.5\margin-\anglesize,-\frametop) --
            (\paperwidth-0.5\margin,-\frametop-\anglesize) --
            (\paperwidth-0.5\margin,-\paperheight+\framebottom+\anglesize) --
            (\paperwidth-0.5\margin-\anglesize,-\paperheight+\framebottom) --
            (0.5\margin,-\paperheight+\framebottom) --
            (0.5\margin,-\frametop-\anglesize) --
            cycle;
        % top bar
        \ifnum\value{page}=1
        \draw[draw=\ColorBackground, fill=VeryLightOrange, very thick]
            (0.5\margin,-0.5\margin) --
            (\paperwidth-0.5\margin,-0.5\margin) --
            (\paperwidth-0.5\margin,-\topbandbottom+\anglesize) --
            (\paperwidth-0.5\margin-\anglesize,-\topbandbottom) --
            (0.5\margin+\anglesize,-\topbandbottom) --
            (0.5\margin,-\topbandbottom+\anglesize) --
            cycle;
        \fi
        % footer bar
        \ifnum\value{page}=\cvlastpage\relax
        \draw[draw=\ColorBackground, fill=VeryLightOrange, very thick]
            (0.5\margin+\anglesize,-\paperheight+\footbandtop) --
            (\paperwidth-0.5\margin-\anglesize,-\paperheight+\footbandtop) --
            (\paperwidth-0.5\margin,-\paperheight+\footbandtop-\anglesize) --
            (\paperwidth-0.5\margin,-\paperheight+0.5\margin) --
            (0.5\margin,-\paperheight+0.5\margin) --
            (0.5\margin,-\paperheight+\footbandtop-\anglesize) --
            cycle;
        \fi
    \end{tikzpicture}}%
}

% Top bar contents, at the very top of page 1.
\newenvironment{TopBar}[1]{% Text color
    \noindent\begin{minipage}[t][\topbarheight][t]{\linewidth}
    \begin{center}
    \color{#1}
}{
    \end{center}
    \end{minipage}\par
    \vspace{5\margin}
}

% Footer bar contents, pinned inside the footer bar of the last page. The
% strut reserves its height, so the text above can never run into it.
\newenvironment{FooterBar}{%
    \par\noindent\rule{0pt}{\footbandtop+2\margin-\pagemargin}%
    \protected@write\@auxout{}{\gdef\string\cvlastpage{\thepage}}%
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=south west, inner sep=0]
            at ([xshift=\pagemargin, yshift=0.5\margin+\footbarpad]current page.south west)
            \bgroup\begin{minipage}[b][\footbarheight][c]{\textwidth}
}{
            \end{minipage}\egroup;
    \end{tikzpicture}\par
}


% \FooterColumn{title}{items}{note}: one footer column. The items sit in a
% fixed-height box, so the notes start at the same height in every column.
\newlength\footitemsheight
\setlength\footitemsheight{4.2\baselineskip}
\newcommand{\FooterColumn}[3]{%
    \begin{minipage}[t]{(\linewidth-8mm)/3}
        \raggedright
        \TextSeparatorBis{\ColorHighlight}{\faCaretRight \hspace{1pt} #1}{}\par
        \vspace{1.5ex}
        \parbox[t][\footitemsheight][t]{\linewidth}{\raggedright #2}\par
        \vspace{0.8ex}
        {\footnotesize\color{MidGrey}#3}
    \end{minipage}%
}


%----------------------------------------------------------------------------------------
%	COMMANDS AND ENVIRONMENTS
%----------------------------------------------------------------------------------------

%%%%%%% Top bar

%%% Name
\newcommand{\Name}[4]% Highlight color, Name, Profession, Age
{
    \vspace{\margin}
    {\Huge{\textbf{\color{#1}#2}}\\
    \Large{#3}
    \hfill
    \Large{#4}}
}

%%%%%%%%%%%%%% Main part

%%%%%% Section title
\newcommand{\MainTitle}[3]{%Background color, Highlight color, Title text
    \begin{tikzpicture}[baseline]    
            \def\backcolor{\ifx\PM\undefined#1\else LightGrey\fi}  
            \node[draw=#2,rounded corners,fill=\backcolor,inner sep=3pt, very thick, anchor=west]
            at (0,0) (box1)
            {\textbf{\Large\color{#2}#3}};
            \node at (\textwidth,0) [rectangle, draw=#2,rounded corners=0.5mm,fill=\backcolor, anchor=east, very thick] (square) {};
        \draw [very thick, draw=#2, inner sep=0pt] (box1) -- (square);
    \end{tikzpicture}\\
}

\def\hrulefill{\leavevmode\leaders\hrule height 0.35mm\hfill\kern\z@} % ~ very thick
%%%%%%% Experience
\newcommand{\Experience}[5]{%Highlight color,  Ttile, Left subtitle, Right subtitle, Description
    \begin{flushleft}
        \large{\textbf{#2\hfill{\small\color{#1}#4}}}\\\vspace{-.4ex}
        \small{{\color{#1}\hrulefill}
        \hspace{1ex}\raisebox{-.4ex}{\color{MainOrange}\textbf{#3}}
        }\\
	    \normalsize{#5}% Description
    \end{flushleft}
}


%%%%%% Common tools

%%% Text separators

\newcommand{\TextSeparatorBis}[3]% Highlight color, Left text, Right text
{
    \noindent\makebox[\linewidth]{\raisebox{-.4ex}{\textbf{\large{#2}}}\hspace{1ex}
    {\color{#1}\hrulefill}
    \hspace{1ex}\raisebox{-.4ex}{\textbf{\large{#3}}}}
}

\newcommand{\SimpleSeparator}[1]% Highlight color
{
    \noindent\makebox[\linewidth]{
    {\color{#1}\hrulefill}}
}

%%% ItemList
\usepackage{enumerate}
\newenvironment{ItemList}[1] % Bullet color
  { \renewcommand{\descriptionlabel}[1]{
    \def\temp{##1}\ifx\temp\empty
        \hspace\labelsep{\textbf{\color{#1}\tiny\faSquare}}% Default bullet
    \else
        \hspace\labelsep{\textbf{\color{#1}##1}}
    \fi
    }%
    \begin{description}}
  {\end{description}}

%%% TripleColumns
\newenvironment{TripleColumns}{
    %%%%%%%%% Use this command to split
    \newcommand{\nextcolumn}{\end{center}\end{minipage}\hfill\begin{minipage}[t]{0.3333\textwidth-0.5\margin}\begin{center}}
    
    \begin{minipage}[t]{0.3333\textwidth-0.5\margin}
    \begin{center}
}{
    \end{center}
    \end{minipage}\\\vspace*{0.15cm}
}

%%% Experience entries (same look as the hand-written entries they replace)
% \Company{name}{dates}
\newcommand{\Company}[2]{%
    \par\addvspace{2ex}%
    {\large\textbf{#1\hfill{\small\color{\ColorHighlight}#2}}}\par\vspace{-.4ex}%
    {\small\color{\ColorHighlight}\hrulefill}\par\nopagebreak
}
% \Role{title}{dates}
\newcommand{\Role}[2]{%
    \par\addvspace{1ex}%
    {\color{MainOrange}\textbf{#1}\hfill{\small\color{\ColorHighlight}\textit{#2}}}\par\nopagebreak
}
