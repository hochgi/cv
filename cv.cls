%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CV
% LaTeX Class
%
% Adapted from Spider CV v1.1 (08/10/22) by ROMAINPC,
% with the spider chart and other unused widgets removed.
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
% Page height = \mainheight + \footerheight; tune both when the content changes.
% \mainheight: the sidebar (and the main column next to it) ends here; the
%              full-width footer area starts right below it.
% \footerheight: height of the full-width area below the sidebar.
\newlength\mainheight
\setlength\mainheight{26.4cm}
\newlength\footerheight
\setlength\footerheight{38.3cm}
\newlength\cvpaperheight
\setlength\cvpaperheight{\mainheight+\footerheight}
\usepackage[margin=\margin,noheadfoot,a4paper, paperheight=\cvpaperheight]{geometry}
\newlength\sidewidth
\setlength\sidewidth{0.25\paperwidth-2\margin}
\newlength\mainwidth
\setlength\mainwidth{\paperwidth-6\margin-\sidewidth}
\newlength\anglesize
\setlength\anglesize{0.25cm}
\newlength\topheight
\setlength\topheight{\sidewidth+0.75cm}
\newlength\profilesize
\setlength\profilesize{\sidewidth-2\margin}

\newlength\sidebarbottom
\setlength\sidebarbottom{-\mainheight}

% Sidebar content is stretched to fill the whole tan area:
% use \vspace{... plus 1fill} between sidebar sections.
\newlength\sidebarheight
\setlength\sidebarheight{\mainheight-\topheight-3\margin+0.4cm-0.3cm}

\newlength\footerwidth
\setlength\footerwidth{\paperwidth-6\margin}

%----------------------------------------------------------------------------------------
%	MAIN SECTIONS
%----------------------------------------------------------------------------------------

\usepackage{ragged2e}
\usepackage[absolute,overlay]{textpos} % option needed to use absolute positionning and to have text on front

\newenvironment{SideBar}[2]{% Background color, Text color
    \begin{tikzpicture}[remember picture,overlay]% put text anywhere

        % \fill[fill=VeryLightOrange, shift={(current page.north west)}];
        
        \draw[draw=#1, fill=VeryLightOrange, shift={(current page.north west)}, very thick]
            (0.5\margin,\sidebarbottom) --
            (0.5\margin,-0.5\margin) --
            (\paperwidth-0.5\margin,-0.5\margin) --
            (\paperwidth-0.5\margin,-\topheight-2\margin) --
            (\sidewidth+2\margin+\anglesize,-\topheight-2\margin) --
            (\sidewidth+2\margin,-\topheight-2\margin-\anglesize) --
            (\sidewidth+2\margin,\sidebarbottom+\anglesize) --
            (\sidewidth+2\margin-\anglesize,\sidebarbottom) --
            cycle;
        \draw [draw=#1, shift={(current page.north west)}, very thick]
            (\paperwidth-0.5\margin-\anglesize,-\topheight-3\margin) --
            (\paperwidth-0.5\margin,-\topheight-3\margin-\anglesize) --
            (\paperwidth-0.5\margin,-\paperheight+0.5\margin+\anglesize) --
            (\paperwidth-0.5\margin-\anglesize,-\paperheight+0.5\margin) --
            (0.5\margin,-\paperheight+0.5\margin) --
            (0.5\margin,\sidebarbottom-\margin-\anglesize) --
            (0.5\margin+\anglesize,\sidebarbottom-\margin);
    \end{tikzpicture}%
    %%%%%%%%%%%%%
    % \TPmargin{}{}
    \begin{textblock*}{\sidewidth}(\margin,\topheight + 3\margin -0.4cm)
    \begin{minipage}[t][\sidebarheight][s]{\sidewidth}
    \begin{center}
    \color{#2}
}{
    \end{center}
    \end{minipage}
    \end{textblock*}
}


\newenvironment{TopBar}[1]{ % Text color
    \begin{textblock*}{\mainwidth}(\sidewidth+3\margin,\margin-0.4cm)
    \begin{center}
    \color{#1}
}{
    \end{center}
    \end{textblock*}
}


\newenvironment{MainPart}{
    \begin{textblock*}{\mainwidth}(\sidewidth+4\margin,\topheight+2\margin)
    \begin{center}
}{
    \end{center}
    \end{textblock*}
}

\newenvironment{Footer}{
    \begin{textblock*}{\footerwidth}(3\margin, -\sidebarbottom+2\margin)
    \begin{center}
}{
    \end{center}
    \end{textblock*}
}


\usetikzlibrary{shapes,decorations}

%%%%%%% Picture
\newcommand{\DefineProfile}[3]% Background color, Highlight color, Img path
{   
    \begin{tikzpicture}[remember picture,overlay]
        % \node [rectangle, draw=SecondaryOrange, rounded corners=0.5mm, very thick,
        % shift={(current page.north west)}, xshift=\anglesize, yshift=-\anglesize,
        % ](s1){};
        % \node [rectangle, draw=SecondaryOrange, rounded corners=0.5mm, very thick,
        % shift={(current page.north west)}, xshift=(\sidewidth+2\margin), yshift=-(\sidewidth+2\margin),
        % ](s2){};
        % \draw [draw=SecondaryOrange, very thick]
        % (s1) -- (s2);
        %%%%%%%%%%%%%%%
        \def\backcolor{\ifx\PM\undefined#1\else LightGrey\fi}
        \node[
            shift={(current page.north west)},
            xshift=(\sidewidth+2\margin)/2,
            yshift=-(\sidewidth+2\margin)/2,
            chamfered rectangle, draw=SecondaryOrange, very thick,
          minimum size=\profilesize,
          fill=\backcolor,
          path picture={
            \node at (path picture bounding box.center){
            \includegraphics[height=\profilesize]{#3}
            };
          }]
          {};
      \end{tikzpicture}
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
