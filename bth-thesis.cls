%% Thesis class template for Blekinge Institute of Technology, extends the memoir class.
%% This document is released under public domain, but the chalmers logo is trademarked.
%% Some words are translated to swedish if babel language is set, otherwise default to English

%% Class options;
% doctorate, licentiate, masters, bachelors, techreport - Sets the type of thesis accordingly
% nocover - Do not print the cover in \maketitle.
% draft - Makes \maketitle more compact, skipping unnecessary blanks
% g5paper - Sets the paper dimensions to 239mm * 169mm
% gu - Joint work for Chalmers + GU
% All options are also passed the standard report class.

%% User commands
% \paper{title}{reference}
% \refpaper{paper numer}              - E.g. \refpaper{A}
% \makethesisdefence                  - Typesets the invitation paper to the thesis defence.
% \maketitle                          - Typesets the frontmatter for the thesis.
% \tableofpapers                      - Called by \maketitle
% \topentry{title}{reference}         - Called by \tableofpapers
% \papernumber                        - Defined to \Alph (can be redefined)
% \presectiontitle                    - Called by \maketitle

%% Input commands (self-explanatory).
% \author{Authors separated with \and}
% \title{text}
% \subtitle{text}
% \firstabstract{text}
% \secondabstract{language}{text}     - Optional
% \keywords{comma separated keywords}
% \preface{text}                      - Optional
% \acknowledgements{text}             - Optional
% \dedication{text}                   - Optional
% \coverfigure{text}                  - Optional
% \covercaption{text}                 - Optional
% \copyrightyear{text}
% \reportno{text}
% \ISBN{text}
% \department{text}
% \faculty{text}                     - Optional
% \thesisin{text}
% \paperwork{text}

%% User commands for the defence invitation
% \opponent{text}
% \oppositiondate{text}

%% Predefined commands (do not need to be set)
% \ISSN{text}
% \printers{text}
% \telephone{text}
% \postcode{text}
% \thesiscontents{text} - Text before the table of papers

%% The predefined babel translations;
% \countryname (Swedish, Sverige)
% \telephonename (Telephone, Telefon)
% \universityname (Chalmers University of Technology, Chalmers tekniska h\"ogskola)
% \seconduniversityname (University of Gothenburg, Göteborgs universitet)
% \covername (Cover, Omslag)
% \acknowledgementsname (Acknowledgements, Tacks\"agelse)
% \keywordsname (Keywords, Nyckelord)
% \masterthesisname (Master's Thesis, Examensarbete)
% \bachelorsthesisname (Bachelor's Thesis, Kandidatarbete)
% \licentiatethesisname (Thesis for the degree of Licentiate of Engineering, Licentiatavhandling)
% \doctoratethesisname (Thesis for the degree of Doctor of Philosophy, Doktorsavhandling)
% \inname (in, i)
% \listofpublicationsname (Thesis, Avhandling)
% \papername (Paper, Artikel)

%% Other
% \presectiontitle{text} - Used for printing titles in the frontmatter
% \presectiontitlestyle{text} - Can be redefined to change the style of the front matter

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{bth-thesis}[2018/05/10 BTH Thesis class]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macro for checking all required commands are set.
\newcommand{\@checkifdefined}[1]{%
  \@ifundefined{@#1}{\ClassError{bth-thesis}{User input `#1` undefined.}{Use the \textbackslash #1{} command to set it.}}{}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conditionals
\newif\if@bachelors
\newif\if@masters
\newif\if@licentiate
\newif\if@doctorate
\newif\if@techreport
\newif\if@projectreport
\newif\if@university
\newif\if@bachelorsormasters
\newif\if@cover
\newif\if@draft
\newif\if@bfivepaper
\newif\if@gitversion

\newif\iffullthesis

\@universityfalse
\@bachelorsfalse
\@mastersfalse
\@licentiatefalse
\@doctoratefalse
\@techreportfalse
\@projectreportfalse
\@bachelorsormastersfalse
\@covertrue
\@draftfalse
\@bfivepaperfalse
\@gitversionfalse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Options of class
% bachelors, masters, licentiate, doctorate, nocover, g5paper
\DeclareOption{bachelors}{\global\@bachelorstrue
  \global\@mastersfalse\global\@licentiatefalse\global\@doctoratefalse\global\@techreportfalse\global\@projectreportfalse}
\DeclareOption{masters}{\global\@masterstrue
  \global\@bachelorsfalse\global\@licentiatefalse\global\@doctoratefalse\global\@techreportfalse\global\@projectreportfalse}
\DeclareOption{licentiate}{\global\@licentiatetrue
  \global\@bachelorsfalse\global\@mastersfalse\global\@doctoratefalse\global\@techreportfalse\global\@projectreportfalse}
\DeclareOption{doctorate}{\global\@doctoratetrue
  \global\@bachelorsfalse\global\@mastersfalse\global\@licentiatefalse\global\@techreportfalse\global\@projectreportfalse}
\DeclareOption{techreport}{\global\@techreporttrue
  \global\@bachelorsfalse\global\@mastersfalse\global\@licentiatefalse\global\@doctoratefalse\global\@projectreportfalse}
\DeclareOption{projectreport}{\global\@projectreporttrue
  \global\@bachelorsfalse\global\@mastersfalse\global\@licentiatefalse\global\@doctoratefalse\global\@techreportfalse}
\DeclareOption{gu}{\global\@universitytrue}
\DeclareOption{nocover}{\global\@coverfalse}
\DeclareOption{draft}{\global\@drafttrue\global\@coverfalse}
\DeclareOption{b5paper}{\global\@bfivepapertrue}

% Passes and class options to the underlying memoir class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions

% Load LaTeX's article class with default options
\LoadClass[11pt,extrafontsizes,b5paper,openright]{memoir}

%%Configure layout with memoir
\headstyles{komalike}
%\headstyles{memman}
%\chapterstyle{demo3}
\chapterstyle{ell}
%\chapterstyle{bringhurst}
%\chapterstyle{madsen}
%\renewcommand*{\printchaptername}{}
\pagestyle{Ruled}
\parskip 0.3em
\linespread{1.05}        % Palatino needs more leading
\setsecnumdepth{subsubsection}

%%Add rule under chapter title.
\renewcommand*{\afterchaptertitle}{ \vskip\onelineskip \hrule\vskip \afterchapskip}
\setlength{\beforechapskip}{0pt}
\setlength{\midchapskip}{2\onelineskip}
\setlength{\afterchapskip}{2\onelineskip}

\renewcommand*{\chapterheadstart}{ \vspace*{15mm}\vspace*{\beforechapskip}}
\renewcommand*{\printchapternum}{%
    \begin{adjustwidth}{}{-\chapindent}
    \hrulefill \smash{\rule{0.4pt}{15mm}}\\
    \hfill
    \raisebox{10mm}[0pt][0pt]{\chapnumfont \thechapter}
    \hspace*{1em}
  \end{adjustwidth}\vspace*{-3.0\onelineskip}}
\renewcommand*{\printchapternonum}{%
    \begin{adjustwidth}{}{-\chapindent}
    \vspace*{0mm}
    \hrulefill \\
  \end{adjustwidth}}

%We want pagenumbers on all pages..
\copypagestyle{cleared}{Ruled}
\makeheadrule{cleared}{0pt}{0pt}
\makeevenhead{cleared}{}{}{}
\makeoddhead{cleared}{}{}{}
\makeevenfoot{cleared}{}{\thepage}{}
\makeoddfoot{cleared}{}{\thepage}{}

%Allow long chapter titles (two lines in left header)
%\setheadfoot{27.5pt}{\footskip}


\newcommand{\fixchapterstyle}{
  \copypagestyle{chapter}{Ruled}
  \makeheadrule{chapter}{0pt}{0pt}
  \pagestyle{Ruled}\headheight=27.5pt
  \makeoddhead{chapter}{}{}{}

%We want pagenumbers on all pages..
  \makeevenfoot{cleared}{\thepage}{}{}
  \makeoddfoot{cleared}{}{}{\thepage}
  \makeevenfoot{chapter}{\thepage}{}{}
  \makeoddfoot{chapter}{}{}{\thepage}

  % \ifgitversion
  % %  \immediate\write18{git log -1 --pretty=format:"Draft: %h @ %ad" > \jobname.info}
  % %   \makeoddfoot{chapter}{}{\textit{\fbox{\input{\jobname.info}}}}{\thepage}
  %    \makeevenfoot{empty}{\thepage}{\textit{Draft: \today}}{}
  %    \makeevenfoot{chapter}{\textit{Draft: \today}}{\thepage}{}
  %    \makeevenfoot{Ruled}{\thepage}{\input|"git log -1 --pretty=format:'Draft: %h'"}}{}
  %    \makeoddfoot{Ruled}{}{\textit{Draft: \today}}{\thepage}
  % \fi
}

% Set up with the required packages
\RequirePackage{etoolbox}
\RequirePackage{textcase}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}

\RequirePackage{iftex} % Automatic check for PDFtex.
\ifPDFTeX
  \usepackage[utf8]{inputenc} % File encoding, you should try to stick to utf8.
  \usepackage[T1]{fontenc}
  %% Use either Gillius ADF or Lato
  %\usepackage{gillius2}
  %\newcommand*{\GillSans}{\gilliustwo}
  \usepackage{lato}
  \newcommand*{\GillSans}{\fontfamily{fla}\selectfont}
\fi

\RequirePackage{ifluatex} % Automatic check for luatex.
\ifluatex
  \RequirePackage{fontspec}
  % \newfontfamily{\GillSans}{Gill Sans Std}
  % \newfontfamily{\GillSans}{Gillius ADF No2}
  \newfontfamily{\GillSans}{Lato}
\fi

\RequirePackage{geometry}
\if@bfivepaper
  \geometry{b5paper}
  % Fix margins for b5book
  \RequirePackage{chngpage}
  \setlrmarginsandblock{1.2\spinemargin}{0.9\foremargin}{*}
  \setulmarginsandblock{0.6\uppermargin}{0.8\lowermargin}{*}
  \setheadfoot{1.4\headheight}{1.4\footskip}
  \checkandfixthelayout%[nearest]
\fi


\RequirePackage[all]{nowidow} %% Keep paragraphs together.

%% Makes the chapters act like a big section
%\RequirePackage{titlesec}
%\titleclass{\chapter}{straight}
%\newcommand{\chapterbreak}{}
%\titleformat{\chapter}[hang]{\bfseries\LARGE}{\thechapter\quad}{0em}{}
%\titlespacing*{\chapter}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}

%% Parts should start a new right side page;
%\titleclass{\part}{straight}
%\newcommand{\partbreak}{\cleardoublepage}
%\titleformat{\part}[display]{\bfseries\huge\centering}{\LARGE\partname\ \thepart}{0em}{}
%\titlespacing*{\part}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}

% Adjustments of floats and equations.
%\setlength{\intextsep}{12pt}
%\setlength{\abovedisplayskip}{6pt}
%\setlength{\belowdisplayskip}{6pt}
%\setlength{\parindent}{5mm}
%\setlength{\abovecaptionskip}{6pt}
%\setlength{\belowcaptionskip}{0pt} % Actual skip = \textfloatsep + \belowcaptionskip
%\setlength{\itemsep}{0pt}

  
%% Format tables 
\let\oldtabular\tabular%
\renewcommand{\tabular}{\tiny\oldtabular}

%% Format figure captions
\captionnamefont{\small\mdseries}
\captiontitlefont{\small\slshape\linespread{.84pt}\selectfont}
\subcaptionsize{\footnotesize}
\subcaptionfont{\bfseries\upshape}
\subcaptionlabelfont{\mdseries\slshape}
\normalcaptionwidth
%\captiondelim{\null\newline}
%\captionstyle[\raggedright]{}
%\captiontitlefinal{.}
\setlength\belowcaptionskip{.5ex}


% Dynamic setup for user loaded packages.
\AtEndPreamble{
 %\@ifpackageloaded{color}{
  %\definecolor{bth_blue}     {RGB}{  0,  0,102}
  %\definecolor{bth_grey}     {RGB}{204,204,204}
  %\definecolor{bth_lightblue}{RGB}{ 28, 78,157}%{1c4e9d}
  %\definecolor{bth_lightgold}{RGB}{239,197, 22}%{efc516}
  %\definecolor{bth_purple}   {RGB}{ 51, 51,102}%{333366}
 %}{}

 % Check for amsmath
 \@ifpackageloaded{amsmath}{
  %\numberwithin{equation}{section}
  %\numberwithin{figure}{section}
  %\numberwithin{table}{section}
 }{\ClassWarning{bth-thesis}{Package 'amsmath' strongly recommended.}}

 % Check and set up biblatex
 \@ifpackageloaded{biblatex}{
 % \defbibheading{bibliography}[\refname]{\addcontentsline{toc}{chapter}{#1}\chapter*{#1}} % Sets the heading for the bibliography

  %\newbibmacro{shortjournal}{\iffieldundef{shortjournal}
   %{\usebibmacro{journal}}%
   %{\printfield[journaltitle]{shortjournal}}} % Adds a default shortjournal

 \defbibheading{subbibliography}{\section{References}} 

  % Let bibtex fix references
  \DeclareSourcemap{%
    \maps[datatype=bibtex]{%
      \map{%
       \step[fieldsource=url, match=\regexp{http*://(link.springer.com|www.mdpi.com|doi.org|portal.acm.org|dx.doi.org/|dl.acm.org/|doi.acm.org|www.tandfonline.com/doi/|ieeexplore.ieee.org/|iospress.metapress.com/|linkinghub.elsevier.com/|caim.simai.eu/|www.sciencedirect.com/|jls.sagepub.com/|books.google|www.cjc-online.ca)}, final]
        \step[fieldset=url, null]
        \step[fieldset=urldate, null]
      }
    }
  }
  }{\ClassWarning{bth-thesis}{Package 'biblatex' strongly recommended}}

 % Check for babel and add more translations
 \@ifpackageloaded{babel}{
  \addto\captionsswedish{%
   \def\countryname{Sverige}%
   \def\cityname{Karlskrona}%
   \def\telephonename{Telefon}%
   \def\universityname{Blekinge Tekniska H\"ogskola}%
 %  \def\seconduniversityname{}%
   \def\covername{Omslag}%
   \def\acknowledgementsname{Tacks\"agelse}%
   \def\keywordsname{Nyckelord}%
   \def\projectthesisname{Projekt}%
   \def\masterthesisname{Examensarbete}%
   \def\bachelorsthesisname{Kandidatarbete}%
   \def\licentiatethesisname{Licentiatavhandling}%
   \def\doctoratethesisname{Doktorsavhandling}%
   \def\techreportname{Teknisk rapport}%
   \def\inname{i}%
   \def\listofpublicationsname{Avhandling}%
   \def\papername{Artikel}%
   \def\publicationname{Publikation}%
  }

  \addto\captionsenglish{%
   \def\countryname{Sweden}%
   \def\cityname{Karlskrona}
   \def\telephonename{Telephone}%
   \def\universityname{Blekinge Institute of Technology}%
  % \def\seconduniversityname{}%
   \def\covername{Cover}%
   \def\acknowledgementsname{Acknowledgements}%
   \def\keywordsname{Keywords}%
   \def\projectthesisname{Project}%
   \def\masterthesisname{Master's thesis}%
   \def\bachelorsthesisname{Bachelor's thesis}%
   \def\licentiatethesisname{Licentiate Dissertation}%
   \def\doctoratethesisname{Thesis for the degree of Doctor of Philosophy}%
   \def\techreportname{Technical report}%
   \def\inname{in}%
   \def\listofpublicationsname{Thesis}%
   \def\papername{Paper}%
   \def\publicationname{Publication}%
  }

  \@ifpackageloaded{siunitx}{
   \addto\extrasswedish{\sisetup{locale = DE}} % German is close to Swedish for units.
   \addto\extrasenglish{\sisetup{locale = US}}
  }{}

 }{\ClassError{bth-thesis}{Package 'babel' required}{}}

 % Document metadata setup
 \@ifpackageloaded{hyperref}{
  \@checkifdefined{author}
  \@checkifdefined{title}
  \@checkifdefined{keywords}
  \renewcommand{\and}{, }
  \hypersetup{
    breaklinks,
    pdfcreator    = \LaTeX{},
    pdfproducer   = \LaTeX{},
    bookmarksopen = true,
    pdfauthor     = \@author,
    pdftitle      = \@title,
    pdfkeywords   = \@keywords,
    colorlinks = true,
    urlcolor   = black,
    citecolor  = black,
    linkcolor  = black,
    filecolor  = black,
  }
 }{\ClassWarning{bth-thesis}{Package 'hyperref' required}}
}

% Needs to be at the end since its language dependent.
\AtEndDocument{
  \hypersetup{
   pdfsubject = \thesisname
  }
}

% User preamble commands
\renewcommand{\author}[1]{\gdef\@author{#1}}
\renewcommand{\title}[1]{\gdef\@title{#1}}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}} % Optional
\newcommand{\firstabstract}[1]{\gdef\@firstabstract{#1}}
\newcommand{\secondabstract}[2]{\gdef\@secondarylanguage{#1}\gdef\@secondabstract{#2}} % Optional
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\preface}[1]{\gdef\@preface{#1}} % Optional
\newcommand{\acknowledgements}[1]{\gdef\@acknowledgements{#1}} % Optional
\newcommand{\dedication}[1]{\gdef\@dedication{#1}} % Optional

\newcommand{\coverfigure}[1]{\gdef\@coverfigure{#1}}
\newcommand{\covercaption}[1]{\gdef\@covercaption{#1}}
\newcommand{\coverpage}[1]{\gdef\@coverpage{#1}}

\newcommand{\copyrightyear}[1]{\gdef\@copyrightyear{#1}}
\newcommand{\reportno}[1]{\gdef\@reportno{#1}}
\newcommand{\ISBN}[1]{\gdef\@ISBN{#1}}
\newcommand{\urn}[1]{\gdef\@urn{#1}}

\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\institution}[1]{\gdef\@institution{#1}}
\newcommand{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand{\thesisin}[1]{\gdef\@thesisin{#1}}
\newcommand{\paperwork}[1]{\gdef\@paperwork{#1}}

\newcommand{\extrafrontmatter}[1]{\gdef\@extrafrontmatter{#1}}

% User commands which shouldn't need to be set.
\newcommand{\ISSN}[1]{\gdef\@ISSN{#1}}
\newcommand{\printers}[1]{\gdef\@printers{#1}}
\newcommand{\telephone}[1]{\gdef\@telephone{#1}}
\newcommand{\postcode}[1]{\gdef\@postcode{#1}}

% Section printed on the table of papers
\newcommand{\thesiscontents}[1]{\gdef\@thesiscontents{#1}}
\thesiscontents{This thesis consists of an extended summary and the following appended papers:}

% User commands for the defence date.
\newcommand{\opponent}[1]{\gdef\@opponent{#1}}
\newcommand{\handledare}[1]{\gdef\@handledare{#1}}
\newcommand{\oppositiondate}[1]{\gdef\@oppositiondate{#1}}
\newcommand{\committie}[1]{\gdef\@committie{#1}}

% Quotation page.
\newcommand{\myquote}[2]{\gdef\@quote{#1} \gdef\@quoteauthor{#2}}

% Some default settings for BTH
\postcode{SE-371 79}
\printers{Some printing company, Sweden}
\telephone{+46 (0)455-385 000}

\reportno{}

% Thesis specific settings
\if@bachelors
  \global\@bachelorsormasterstrue
  \ISSN{}
  \def\titlepage@edge{draw}
  \def\titlepage@bthcolor{black}
  \def\titlepage@bg{}
  \def\titlepage@logotype{Avancez_invert}
  \def\titlepage@chagu{Cha_GU_blue_eng}
  \def\thesisname{\bachelorsthesisname}
  \def\@reportseries{\thesisname}
\fi
\if@masters
  \global\@bachelorsormasterstrue
  \ISSN{}
  \def\titlepage@edge{draw}
  \def\titlepage@bthcolor{black}
  \def\titlepage@bg{\draw[step=5mm,black] (0,0) grid (\paperwidth,0.25\paperheight);}
  \def\titlepage@logotype{Avancez_white}
  \def\titlepage@chagu{Cha_GU_bluewhite_eng}
  \def\thesisname{\masterthesisname}
  \def\@reportseries{\thesisname}
\fi
\if@licentiate
  \ISSN{1650-2140}
  \def\titlepage@edge{}
  \def\titlepage@bthcolor{white}
  \def\titlepage@bg{\fill[bth_grey] (0,0) rectangle (\paperwidth,0.25\paperheight);}
  \def\titlepage@logotype{Avancez_black}
  \def\titlepage@chagu{Cha_GU_black_eng}
  \def\thesisname{\licentiatethesisname}
  \def\@reportseries{\thesisname}
\fi
\if@doctorate
  \ISSN{1653-2090}
  \def\titlepage@edge{}
  \def\titlepage@bthcolor{white}
  % The bth_blue is supposely the correct one, but it doesn't match at all.
  %\def\titlepage@bg{\fill[bth_blue] (0,0) rectangle (\paperwidth,0.25\paperheight);}
  %\def\titlepage@logotype{Avancez_gold}
  % These colors are taken from the example covers, might lighter colors (looks closer to the printed version).
  %\def\titlepage@bg{\fill[bth_lightblue] (0,0) rectangle (\paperwidth,0.25\paperheight);}
  %\def\titlepage@logotype{Avancez_lightgold}
  %\def\titlepage@chagu{Cha_GU_white_eng}
  \def\thesisname{\doctoratethesisname}
  \def\@reportseries{Doktorsavhandlingar vid \universityname\\Ny serie nr.\ }
\fi
\if@techreport
  \ISSN{1652-8549}
  \def\titlepage@edge{draw}
  \def\titlepage@bthcolor{black}
  \def\titlepage@bg{\draw[step=5mm,black] (0,0) grid (\paperwidth,0.25\paperheight);}
  \def\titlepage@logotype{Avancez_white}
  \def\titlepage@chagu{Cha_GU_bluewhite_eng}
  \def\thesisname{\techreportname}
  \def\@reportseries{\thesisname}
\fi
\if@projectreport
  \def\thesisname{\projectthesisname}
  \def\@reportseries{\thesisname}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Commands for the thesis papers.
\newcounter{paper}
\setcounter{paper}{0}
\newcommand{\papernumber}{\Alph}

% Commands for the additional publications.
\newcounter{publication}
\setcounter{publication}{0}
\newcommand{\publicationnumber}{\Roman}

% Customizable lengths
\newlength{\topcolumn}
\newlength{\toppadding}
\setlength{\topcolumn}{0.15\textwidth}
\setlength{\toppadding}{1em}

% Customizable command for how the entry is rendered.
% {Type}{Number}{Full citation}
\newcommand{\topentry}[3]{%
  \noindent\parbox[c]{\topcolumn}{\large \hyperlink{#1:#2}{\textbf{#1\ #2}}\hfil}%
  \hspace{\toppadding}%
  \parbox{\textwidth-\topcolumn-\toppadding}{#3}\par\vskip 1em%
}

% Adds text to be written in the list of papers/publications
\newcommand{\toptext}[1]{%
 \addtocontents{top}{%
  \protect\noindent #1\\[1em]
 }
}

% Main command, works similarly as \section.
\newcommand{\paper}[2]{%
 \stepcounter{paper}
 \addtocontents{top}{%
  \protect\topentry{\papername}{\papernumber{paper}}{#2}
 }
 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi
 % Links are always nice;
 \hypertarget{\papername:\papernumber{paper}}{\mbox{}}
 %\phantomsection
 %\addcontentsline{toc}{chapter}{Paper \papernumber{paper}}
 %\belowpdfbookmark{Paper \papernumber{paper}}{paper:\papernumber{paper}}
 \thispagestyle{empty}
 \vspace*{0em}
 \begin{flushright}
  {\huge\textbf{Paper \papernumber{paper}}}
 \end{flushright}
 \vspace*{5em}
 {\noindent\Large\textbf{#1}\par}
%  \vspace*{2em}
%  \begin{center}
%  \begin{minipage}{0.8\textwidth}
%    {\noindent\large#2\par}
%  \end{minipage}
%  \end{center}
 \cleardoublepage
}

% Convenient hyperlinked reference for the introduction text. Usage: \refpaper{A}
\newcommand{\refpaper}[1]{\hyperlink{\papername:#1}{\papername~{#1}}}

% Very similar command to \paper, for additional publications.
\newcommand{\publication}[2]{%
 \stepcounter{publication}
 \addtocontents{top}{%
  \protect\topentry{\publicationname}{\publicationnumber{publication}}{#2}
 }
 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi
 % Links are always nice;
 \hypertarget{\publicationname:\publicationnumber{publication}}{\mbox{}}

 \thispagestyle{empty}
 \vspace*{0em}
 \begin{flushright}
  {\huge\textbf{\publicationname\ \publicationnumber{publication}}}
 \end{flushright}
 \vspace*{5em}
 {\noindent\Large\textbf{#1}\par}
 \newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads the *.top file which is automatically generated by \paper
% Works similarly as \tableofcontents
\newcommand{\tableofpapers}{%
\vskip 1em
\parskip 0.2em
\@starttoc{top}
\parskip 1em
\vskip 1em
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reads the *.topub file which is automatically generated by \paper
% Works similarly as \tableofcontents
\newcommand{\tableofpublications}{%
\vskip 1em
\parskip 0.2em
\@starttoc{topub}
\parskip 1em
\vskip 1em
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Renew the table of contents title to fit the rest of the frontmatter
\renewcommand{\tableofcontents}{
 %\phantomsection\addcontentsline{toc}{chapter}{\contentsname}
 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi
 %
 \chapter*{\contentsname}\pagestyle{plain}
 \parskip 0.2em
 \@starttoc{toc}
 \parskip 1em
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command for the titles.
\newcommand{\presectiontitlestyle}[1]{\begin{center}\Large\textsc{#1}\end{center}}
%\newcommand{\presectiontitlestyle}[1]{\chapter*{#1}}
\newcommand{\presectiontitle}[1]{
  \phantomsection\addcontentsline{toc}{section}{#1}
  \presectiontitlestyle{#1}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All the front pages;

% Introducing some new lengths for the front page
%\newlength{\headerheight}
%\newlength{\headeroffset}
%\setlength{\headerheight}{0.215\paperheight}%~6.4cm in a4
%\setlength{\headeroffset}{0.125\headerheight}%~0.8cm in a4

\AtEndPreamble{
\newcommand{\makecoverpage}{
 \pagestyle{empty}
 \calccentering{\unitlength}
   \begin{adjustwidth*}{\unitlength}{-\unitlength}
 \begin{center}
%  \@ifundefined{@coverfigure}{}{\@coverfigure}
   \vspace*{1cm}
   {\huge\GillSans{\textbf{\noindent\@title}}\par} % title, 21
   \@ifundefined{@subtitle}{}{{\Large\GillSans{\noindent \@subtitle}\par}} % subtitle, 16
   \if@bachelorsormasters
   {\normalsize\noindent{\thesisname\ \inname\ \@thesisin}\par} % 14 thesis in programmename (only bachelor's and master's)
   \fi
   \vskip 1.5em
   {\renewcommand{\and}{\\}\Large\noindent \GillSans{\@author}\par}% 18
   \vskip 1.5em
 \end{center}
   \end{adjustwidth*}\vspace*{3em}
 % Second page, blank
 \newpage
 \mbox{}
}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\maketitlepage}{
\@ifundefined{@coverpage}{
 \@checkifdefined{thesisin}
 \@checkifdefined{reportno}
 \@checkifdefined{title}
 \@checkifdefined{author}
 \@checkifdefined{department}
 \@checkifdefined{copyrightyear}

 \newpage\thispagestyle{empty}
 \newlength{\currentparskip}
 \setlength{\currentparskip}{\parskip}
 \parskip 0pt
 \calccentering{\unitlength}
 \begin{adjustwidth*}{\unitlength}{-\unitlength}
 \begin{center}{\GillSans{
   {\large \universityname\ \MakeTextLowercase{\thesisname}\ series\\
 No: \@reportno\par}
  %{\citynameoteborgakeUppercase{\thesisname\ \inname\ \@thesisin}\par}
  \vspace*{\stretch{1}}
  {\LARGE \textbf{\@title}\par}
  \vskip 0.2em
  {\large \@ifundefined{@subtitle}{}{\textbf{\@subtitle}}\par}
  \vskip 5em
  {\large \renewcommand{\and}{\NoCaseChange{\\}}\textbf{\@author}\par}
  \vskip 4em
  {\large \thesisname\ in \\\@thesisin\par}
  \vspace*{\stretch{2}}
  {\includegraphics[width=0.25\textwidth]{black_BTH_CMYK}\par}
  \vskip 3em
  \@ifundefined{@faculty}{}{\@faculty\\}
  {\@department\\
  {\universityname}
   \if@university
    \\{\seconduniversityname}
   \fi\\
  \vskip 0.5em
  \MakeTextUppercase{\countryname}}
}}
 \end{center}
 \end{adjustwidth*}
 \setlength{\parskip}{\currentparskip}
\enlargethispage{2\onelineskip}
  \clearpage
}{
   \includepdf[pages={3,2}]{\@coverpage}
 }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeprintinfopage}{
 \@checkifdefined{thesisin}
 \@checkifdefined{reportno}
 \@checkifdefined{title}
 \@checkifdefined{author}
 \@checkifdefined{department}
 \@checkifdefined{copyrightyear}
 \@checkifdefined{ISSN}

 \newpage\thispagestyle{empty}
 %\enlargethispage{0.5\paperheight}
 \vspace*{\stretch{1}}
 {\GillSans{%
  \noindent \@copyrightyear\ {\renewcommand{\and}{, }\@author}\\
  \@ifundefined{@faculty}{}{\@faculty\\}
  \@department\\
  Publisher: \universityname,\\
  \@postcode\ \cityname, \countryname\\
  Printed by \@printers\ \@copyrightyear\\
   \@ifundefined{@ISBN}{}{ISBN \@ISBN\\}
  \ifdefempty{\@ISSN}{}{ISSN \@ISSN\\}%
  \par}}
\enlargethispage{2\onelineskip}
  \clearpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makequotepage}{
 \@checkifdefined{quote}
 \@checkifdefined{quoteauthor}

 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi

 \thispagestyle{empty}
  \vspace*{\fill}
  \begin{quote}
  \@quote \\[0.5\baselineskip]
  \hspace*{\fill} \@quoteauthor \\ %Carl Sagan, \textit{Cosmos}, 1980.% and Reuben Thomas
  \end{quote}
  \vspace*{\fill}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeabstractpage}{
 \@checkifdefined{thesisin}
 \@checkifdefined{title}
 \@checkifdefined{author}
 \@checkifdefined{department}
 \@checkifdefined{firstabstract}
 \@checkifdefined{keywords}

 \if@draft
  \newpage
 \else
  \iffullthesis
   \cleardoublepage
  \else
   \newpage
  \fi
 \fi

 \pagenumbering{roman}
 \setcounter{page}{1} % Necessary to give the first pages a unique identifier using hyperref.
 %\addcontentsline{toc}{section}{\abstractname}
 \pagestyle{plain}
 \presectiontitle{\abstractname}
 \@firstabstract
 %\@checkifdefined{@secondabstract}
 \ifdefempty{\@keywords}{}{
 \vskip 0.6em
 \noindent \keywordsname: \@keywords
 }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Trick to fully expand the argument
\newenvironment{Otherlanguage}[1]{%
  \begingroup
  \edef\temp{\endgroup\noexpand\otherlanguage{#1}}%
  \temp
}{\endotherlanguage}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makesecondabstractpage}{%
 \@checkifdefined{secondarylanguage}
 \@checkifdefined{@secondabstract}
 \newpage
 \begin{Otherlanguage}{\@secondarylanguage}
  \presectiontitle{\abstractname}
  %\addcontentsline{toc}{section}{\abstractname}
  \@secondabstract
 \end{Otherlanguage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makededicationpage}{%
\@ifundefined{@dedication}{}{
 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi
 \vspace*{0.2\textheight}
 \begin{center}\@dedication\end{center}
}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeprefacepage}{%
 \chapter*{\prefacename}
 \addcontentsline{toc}{section}{\prefacename}
 \@preface
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\makeacknowledgementspage}{% Note: Doesn't need a new page.
\@ifundefined{@acknowledgements}{}{
 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi
 \chapter*{\acknowledgementsname}
\addcontentsline{toc}{section}{\acknowledgementsname}
 %\presectiontitle{\acknowledgementsname}
 \@acknowledgements
}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\maketableofpaperspage}{
 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi
 \phantomsection
 \presectiontitle{\listofpublicationsname}
 \noindent \@thesiscontents
 \tableofpapers
 \@ifundefined{@paperwork}{}{
   \noindent \@paperwork
 }
 \tableofpublications
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\maketitle}{%
 \setcounter{page}{-99} % Necessary to give the first pages a unique identifier using hyperref.

 \@ifundefined{@coverpage}{
  \if@draft\else
  \if@cover
   \makecoverpage
  \fi
 \fi

 \if@draft\else
  \maketitlepage

  \makeprintinfopage
 \fi
 }{
   \includepdf[pages={1,2,3,4}]{\@coverpage}
 }

  % Quote
 \if@draft\else
 \@ifundefined{@quote}{}{
  \makequotepage
 }
 \fi

 \makeabstractpage

 % Empty or second abstract
 \@ifundefined{@secondabstract}{}{
  \makesecondabstractpage
 }

 \@ifundefined{@dedication}{}{
  \makededicationpage
 }

 % Preface and acknowledgements
 \@ifundefined{@preface}{}{
  \makeprefacepage
 }
 \@ifundefined{@acknowledgements}{}{
  \makeacknowledgementspage
 }

 \@ifundefined{@extrafrontmatter}{}{
  \cleardoublepage
  \@extrafrontmatter
 }

 \tableofcontents

 % Sets up page numbering for the rest of the document.
 \if@draft
  \newpage
 \else
  \cleardoublepage
 \fi
 \pagenumbering{arabic}
 \pagestyle{Ruled}
}

\if@projectreport
  \renewcommand{\maketitle}{%
   \setcounter{page}{-99} % Necessary to give the first pages a unique identifier using hyperref.
   \maketitlepage
   \cleardoublepage

 % Preface and acknowledgements
 \@ifundefined{@preface}{}{
  \makeprefacepage
 }
 \@ifundefined{@acknowledgements}{}{
  \makeacknowledgementspage
 }

 \@ifundefined{@extrafrontmatter}{}{
  \cleardoublepage
  \@extrafrontmatter
 }

   \tableofcontents
   \cleardoublepage
   \pagenumbering{arabic}
  }
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page + abstract for defence of thesis.
\newcommand{\makethesisdefence}{
% \@checkifdefined{thesisin}
% \@checkifdefined{reportno}
% \@checkifdefined{title}
% \@checkifdefined{author}
% \@checkifdefined{department}
% \@checkifdefined{copyrightyear}
\newpage\thispagestyle{empty}
\enlargethispage{4\onelineskip}
\newlength{\currentparskip}
\setlength{\currentparskip}{\parskip}
\parskip 0pt
\calccentering{\unitlength}
\begin{adjustwidth*}{\unitlength}{-\unitlength}
\GillSans{\begin{center}
  {\large \universityname \\
  Doctoral Dissertation Series No \@reportno\\
 \@ifundefined{@ISSN}{}{ISSN \@ISSN\\}
 \@ifundefined{@ISBN}{}{ISBN \@ISBN\par}
}
 %{\citynameoteborgakeUppercase{\thesisname\ \inname\ \@thesisin}\par}
 \vskip 4em
 {\LARGE \textbf{\@title}\\}
% \vskip 0.2em
 {\Large \@ifundefined{@subtitle}{}{\@subtitle}\par}
 \vskip 2em
 {\Large \renewcommand{\and}{\NoCaseChange{\\}}{\@author}\par}
 \vskip 4em

 \begin{otherlanguage}{swedish}
 {\large{Akademisk avhandling}\\
 som f\"or avl\"aggande av teknologie doktorsexamen vid \universityname\  kommer att offentligt f\"orsvaras i sal \@oppositiondate.\par}
% {\large \thesisname\ in \\\@thesisin\par}

\vskip 2em
 \begin{minipage}[t]{.45\textwidth}
 \centering
   Handledare:\\
   {\small\@handledare}
 \end{minipage}
 \quad
 \begin{minipage}[t]{.45\textwidth}
 \centering
   Opponent:\\
   {\small\@opponent}
\vskip 0.6em
   Betygsn\"amnd:\\
  {\small\@committie}
 \end{minipage}

 \vspace*{\stretch{2}}
 {\includegraphics[width=2.25cm]{black_BTH_CMYK}\par}
 \vskip 1em
 {\universityname\\
 \@institution\\
 }\par
\end{otherlanguage}

\end{center}}
\end{adjustwidth*}
%

\newpage\thispagestyle{empty}
\parskip 1em
\GillSans{
{\centering \textbf{\abstractname}\par}

%\vskip 1em
{\parindent0pt
\@firstabstract
}
\ifdefempty{\@keywords}{}{
\vskip 1em
\noindent \keywordsname: \@keywords
}
}
\setlength{\parskip}{\currentparskip}

\end{document}
}
