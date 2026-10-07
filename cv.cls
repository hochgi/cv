%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CV
% LaTeX Class
%
% A4, flat, sans-serif CV layout:
%   page 1  - a tinted sidebar (photo, contact, education, extras) on the left,
%             header + experience in the main column on the right;
%   page 2+ - experience continues at full width, with normal page breaks.
%
% Originally adapted from Spider CV v1.1 by ROMAINPC (MIT License),
% itself inspired by developercv, limecv and altacv.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax
\LoadClass{extarticle}

%----------------------------------------------------------------------------------------
%	PACKAGES
%----------------------------------------------------------------------------------------

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[sfdefault]{roboto}
\usepackage[letterspace=150]{microtype}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{tikz}
\usepackage{calc}
\usepackage{fontawesome}
\usepackage{ragged2e}
\usepackage{amssymb}

\setlength{\parindent}{0mm}
\pagestyle{empty}

% Left-aligned text without hyphenation: no split keywords
\AddToHook{begindocument/end}{\raggedright\hyphenpenalty=10000\exhyphenpenalty=10000}

%----------------------------------------------------------------------------------------
%	COLORS
%----------------------------------------------------------------------------------------

\definecolor{Ink}{HTML}{1F2328}       % body text
\definecolor{Muted}{HTML}{6A737D}     % dates, secondary text
\definecolor{Accent}{HTML}{D9480F}    % role titles, section titles, links
\definecolor{SideBg}{HTML}{F6F3EE}    % page-1 sidebar background
\definecolor{Rule}{HTML}{E2DCD3}      % thin rules

\AtBeginDocument{\color{Ink}}
\usepackage{hyperref}
\hypersetup{colorlinks, breaklinks, urlcolor=Accent, linkcolor=Accent}

%----------------------------------------------------------------------------------------
%	GEOMETRY
%----------------------------------------------------------------------------------------
% Page 1 leaves room for the sidebar on the left; \NextPages switches to full
% width (and starts a new page) for the rest of the CV.

\newlength\sidebarwidth   \setlength\sidebarwidth{66mm}
\newlength\sidebarpad     \setlength\sidebarpad{8mm}
\newlength\pagemargin     \setlength\pagemargin{13mm}

\usepackage[a4paper, top=\pagemargin, bottom=\pagemargin, right=\pagemargin,
            left=\sidebarwidth+10mm]{geometry}

\newcommand{\NextPages}{\newgeometry{margin=\pagemargin}}

%----------------------------------------------------------------------------------------
%	SIDEBAR (page 1)
%----------------------------------------------------------------------------------------

% \Sidebar{photo}{content}: tinted full-height column with a round photo on top.
% Footnotes inside the content are typeset at the bottom of the sidebar text.
\newcommand{\Sidebar}[2]{%
    \begin{tikzpicture}[remember picture, overlay]
        \fill[SideBg] (current page.north west) rectangle
            ([xshift=\sidebarwidth]current page.south west);
        \begin{scope}
            \clip ([xshift=\sidebarwidth/2, yshift=-\pagemargin-19mm]current page.north west) circle (19mm);
            \node[anchor=center, inner sep=0]
                at ([xshift=\sidebarwidth/2, yshift=-\pagemargin-19mm]current page.north west)
                {\includegraphics[width=38mm]{#1}};
        \end{scope}
        \node[anchor=north west, inner sep=0]
            at ([xshift=\sidebarpad, yshift=-\pagemargin-44mm]current page.north west)
            {\begin{minipage}[t]{\sidebarwidth-2\sidebarpad}\raggedright\small #2\end{minipage}};
    \end{tikzpicture}%
}

% Sidebar section title
\newcommand{\SideSection}[1]{%
    \par\vspace{5mm}%
    {\color{Accent}\bfseries\footnotesize\textls{\MakeUppercase{#1}}}\par
    \vspace{-1mm}{\color{Rule}\rule{\linewidth}{0.6pt}}\par\vspace{1.5mm}%
}

% Sidebar contact line: \ContactItem{icon}{text}
\newcommand{\ContactItem}[2]{%
    \makebox[5mm][l]{\color{Accent}#1}#2\par\vspace{1mm}%
}

% Sidebar education entry: \Degree{title}{place}{dates}{details}
\newcommand{\Degree}[4]{%
    {\bfseries #1}\par
    {\color{Muted}#2}\par
    {\footnotesize\color{Muted}#3}\par
    \ifx\relax#4\relax\else{\footnotesize #4}\par\fi
    \vspace{2mm}%
}

%----------------------------------------------------------------------------------------
%	MAIN COLUMN
%----------------------------------------------------------------------------------------

% \Header{name}{title}
\newcommand{\Header}[2]{%
    {\fontsize{30}{34}\selectfont\bfseries #1}\par\vspace{1.5mm}
    {\large\color{Accent}\mdseries #2}\par\vspace{3mm}
}

% Main section title, e.g. \Section{Experience}
\newcommand{\Section}[1]{%
    \par\vspace{5mm}%
    {\color{Accent}\bfseries\small\textls{\MakeUppercase{#1}}}%
    \hspace{3mm}{\color{Rule}\leaders\hrule height 0.6pt\hfill\kern0pt}\par
    \vspace{2mm}%
}

% \Company{name}{dates}
\newcommand{\Company}[2]{%
    \par\vspace{3.5mm}\nopagebreak
    {\large\bfseries #1}\hfill{\small\color{Muted}#2}\par\nopagebreak
    \vspace{0.5mm}\nopagebreak
}

% \Role{title}{dates}
\newcommand{\Role}[2]{%
    \par\vspace{1.5mm}\nopagebreak
    {\color{Accent}\bfseries #1}\hfill{\small\color{Muted}#2}\par\nopagebreak
    \vspace{0.3mm}\nopagebreak
}

% Compact bullet list
\newenvironment{Highlights}{%
    \begin{list}{\color{Accent}\raisebox{0.2ex}{\scriptsize$\blacktriangleright$}}{%
        \setlength\leftmargin{4mm}\setlength\labelwidth{3mm}\setlength\labelsep{1.5mm}%
        \setlength\itemsep{1mm}\setlength\parsep{0pt}\setlength\topsep{1mm}\setlength\partopsep{0pt}}%
}{\end{list}}
