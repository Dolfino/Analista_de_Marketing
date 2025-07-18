%%%%%%%%%%%%%%%%%
% This is altacv.cls (v1.5, 8 May 2021) written by
% LianTze Lim (liantze@gmail.com).
%
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%
%%
% Contributions:
% - https://github.com/akreuzer Added ragged2e option (5 Nov 2018)
% - https://github.com/stefanogermano Fixed bad boxes and undefined font shape (July 2018)
% - https://github.com/foohyfooh Fixed blank spaces in \cvevent and bad link in README.md (June 2018)
% - https://github.com/logological Remove redundant hyperref and typos (Apr 2021)
%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{altacv}[2024/10/31 AltaCV v1.7.3, yet another alternative class for a resume/curriculum vitae.]

%% v1.1: Optionally load academicons
%% v1.4: Nope, academicons is unnecessary; fontawesome5 has \faOrcid.
%% v1.7.3: Re backward compatibility we'll now load academicons automatically for \aiOrcid if ≤TL2019 i.e. if \faOrcid undefined
\DeclareOption{academicons}{\ClassWarning{altacv}{academicons option is now obsolete and unnecessary.}}

%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}

%% v1.3: load hyperref for clickable hyperlinks
\newif\if@withhyper
\DeclareOption{withhyper}{%
  \@withhypertrue%
  \AtEndOfPackage{\RequirePackage[pdftex]{hyperref}}%
}
\ProcessOptions\relax

\LoadClass{article}
\RequirePackage{etoolbox}
% v1.7.3 Load xcolor early to avoid receiving `hyperref` option from pdfx package
\RequirePackage{xcolor}
%% v1.3.2 Hopefully this helps make the PDF
%% file more 'friendly' with copy-paste etc
\RequirePackage[a-1b]{pdfx}
\RequirePackage{accsupp}
%% v1.7.3 Avoid 'Token not allowed' when \\ used with accsupp
%% v1.3.3 Temporary fix for pdfx and biblatex incompatibility
%% (Thanks to @badetitou for highlighting this issue)
%% https://github.com/plk/biblatex/issues/1044
%% Will be removed when fix is released in biblatex 3.16
% \catcode30=12
\pdfstringdefDisableCommands{
	\let\\\space
}

\RequirePackage{xparse}
\RequirePackage[margin=2cm]{geometry}
\RequirePackage[fixed]{fontawesome5}%[2020-01-15]

%------Package Add-----------------
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{scrlfile}
\RequirePackage{xcolor}

%---------------------------------------------------------------
\usepackage{kantlipsum}   %% only for demo
\usepackage{lmodern}
\usepackage{marvosym}
\usepackage{graphicx}
\usepackage[pt-PT]{datetime2}
\usepackage{environ}
%----------------------------------

% 1.7.3 For backward compatibility
\providecommand\IfFormatAtLeastTF{\@ifl@t@r\fmtversion}
\IfFormatAtLeastTF{2021-11-15}{}{\RequirePackage{scrlfile}}

% v1.7.2 Add simpleicons to provide X icon
% v1.7.3 But first check if the package files exist
\IfFileExists{simpleiconsglyphs-pdftex.tex}{\RequirePackage{simpleicons}}{}

% v1.7.3 Use iftex for easier access to \iftutex
\RequirePackage{iftex}
% ...but still check for backward compatibility
\ifundef{\iftutex}{%
	\newif\iftutex
	\ifxetex\tutextrue
	\else
	\ifluatex\tutextrue\else\tutexfalse\fi
	\fi
}{}
\iftutex
\RequirePackage{fontspec}
\else
%% v1.3.2 attempts to make ligatures
%% copy-paste as normal characters
\RequirePackage{cmap}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\input{glyphtounicode}
\pdfglyphtounicode{f_f}{FB00}
\pdfglyphtounicode{f_f_i}{FB03}
\pdfglyphtounicode{f_f_l}{FB04}
\pdfglyphtounicode{f_i}{FB01}
\pdfgentounicode=1
\fi

\if@raggedtwoe
\RequirePackage[newcommands]{ragged2e}
\fi

% 1.7.3 For backward compatibility re hooks management
\if@withhyper
\IfFormatAtLeastTF{2020-10-01}{%
	\AddToHook{begindocument/before}{\hypersetup{hidelinks}\urlstyle{same}}
}{%
	\AtBeginDocument{\hypersetup{hidelinks}\urlstyle{same}}
}
\fi



%-------Color Add----------------
\definecolor{Graphite}{HTML}{4B4E53}
\definecolor{LightGrey}{HTML}{666666}
\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{blackened}{HTML}{2B2B2B}
\definecolor{cvblue}{HTML}{0E5484}
\definecolor{quote}{HTML}{4B4E53}

\colorlet{maincolor}{cvblue}
% profile section color (sidebar/left column)
\colorlet{pseccolor}{maincolor!90}
% color used for all icon arguments
\colorlet{iconcolor}{maincolor!90}
%--------------------------------

\colorlet{accent}{blue!70!black}
\colorlet{emphasis}{black}
\colorlet{heading}{black}
\colorlet{headingrule}{black}
\colorlet{subheading}{emphasis}
\colorlet{body}{LightGrey}
\colorlet{resume}{Graphite}
\colorlet{name}{heading}
\colorlet{tagline}{accent}

% Renamed or added v1.7
\newcommand{\cvItemMarker}{{\small\textbullet}}
\newcommand{\cvRatingMarker}{\faCircle}
\let\itemmarker\cvItemMarker      % for backward compatibility
\let\ratingmarker\cvRatingMarker  % for backward compatibility
\newcommand{\cvDateMarker}{\faCalendar[regular]}
\newcommand{\cvLocationMarker}{\faMapMarker}
\newcommand{\locationname}{Location}
\newcommand{\datename}{Date}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage[inline]{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}
\setlist[itemize]{label=\cvItemMarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{trimclip}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\smallskip}

\newenvironment{fullwidth}{%
	\begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
	{\end{adjustwidth}}

%% v1.3.1 \detokenize will break UTF-8 in pdflatex
%% Using alternative from https://tex.stackexchange.com/a/530911/226
\newcommand{\utffriendlydetokenize}[1]{%
	\scantokens{%
		\catcode`\_=12%
		%   \catcode`\^=12%
		%   \catcode`\{=12%
		%   \catcode`\}=12%
		\catcode`\&=12%
		\catcode`\$=12%
		\catcode`\#=12%
		\catcode`\~=12%
		%   \catcode`\\=12%
		{#1}%
	}%
}
%% v1.3: Incorporating hyperlinks
%% v1.3.1: using \utffriendlydetokenize to avoid breaking unicode
%% v1.6: Use accsupp so that when copying/pasting the icon from PDF to a text
%%       file, the icon name is pasted
%% v1.7: Some tweaks/corrections so that accsupp is for icons only
%% v1.7.1: Bugfix to support some symbol commands e.g. academicons commands
\ExplSyntaxOn
\NewDocumentCommand{\printinfo}{m m o}{%
	\IfNoValueTF{#3}{%
		\mbox{\textcolor{accent}%
			{\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
			~\utffriendlydetokenize{#2}\hspace{2em}}%
	}{%
		\if@withhyper%
		\mbox{\textcolor{accent}%
			{\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
			~\href{#3}{\utffriendlydetokenize{#2}}\hspace{2em}}
		\else%
		\ClassWarning{Please specify [withhyper] option to enable hyperlinks. Printing out full hyperlink prefix #1 for now.}%
		\mbox{\textcolor{accent}
			{\BeginAccSupp{method=escape,ActualText={\detokenize{#1}:}}\normalfont #1\EndAccSupp{}}%
			~{\utffriendlydetokenize{#3#2}}\hspace{2em}}%
		\fi%
	}%
}%

%% v1.3: Exploring convenient creation of fields
%% v1.6: Add starred mode to create \printinfo with full URL
\NewDocumentCommand{\NewInfoField}{s m m o}{%
	\IfBooleanF{#1}{
		\IfNoValueF{#4}{\csdef{#2 hyperprefix}{#4}}%
	}
	\csdef{#2 symbol}{#3}
	\IfBooleanTF{#1}
	{ \csdef{#2}##1##2{%
			\if@withhyper
			\IfNoValueTF {##2}
			{\printinfo{\csuse{#2 symbol}}{##1}}%
			{\printinfo{\csuse{#2 symbol}}{##1}[##2]}%
			\else
			\printinfo{\csuse{#2 symbol}}{##1}%
			\fi%
		}%
	}
	{ \csdef{#2}##1{%
			\if@withhyper
			\IfNoValueTF {#4}
			{\printinfo{\csuse{#2 symbol}}{##1}}%
			{\printinfo{\csuse{#2 symbol}}{##1}[\csuse{#2 hyperprefix}##1]}%
			\else
			\printinfo{\csuse{#2 symbol}}{##1}%
			\fi%
		}%
	}
}
\ExplSyntaxOff

%% v1.0: Add Cabeçalho
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}
\NewInfoField{habilitacao}{\faMotorcycle \faCar*}
\NewInfoField{email}{\faAt}[mailto:]
\NewInfoField{mailaddress}{\faEnvelope}
\NewInfoField{phone}{\faWhatsapp}[tel:]
\NewInfoField{homepage}{\faGlobe}[https://]
\NewInfoField{Behance}{\faBehance}[https://www.behance.net/]
\NewInfoField{twitter}{\faTwitter}[https://twitter.com/]
% v1.7.2 twitter.com is now X.com; v1.7.3 but only use the new icon if it's been defined
\ifcsdef{simpleicon@xicon}
{\NewInfoField{xtwitter}{\raisebox{-0.2ex}{\scalebox{0.95}{\simpleicon{x}}}\,}[https://x.com/]}
{\let\xtwitter\twitter%
	\pretocmd{\xtwitter}{\ClassWarning{altacv}{You tried to use \string\xtwitter, but the new X icon isn't available. Please ensure you have updated the `simpleicons' package. Falling back to \string\twitter\space icon for now}}{}{}%
}
\NewInfoField{linkedin}{\faLinkedin}[https://linkedin.com/in/marketing-administrador-]
\NewInfoField{github}{\faGithub}[https://github.com/]
% v1.7.3 Backward compatibility for ORCiD icon
\ifdef{\faOrcid}{
	\NewInfoField{orcid}{\faOrcid}[https://orcid.org/]
}{\iftutex
	\RequirePackage{academicons}
	\NewInfoField{orcid}{\aiOrcid\space}[https://orcid.org/]
	\else
	\ClassWarning{altacv}{ORCID icon for \string\orcid\space unavailable in pdflatex. Please compile with XeLaTeX or LuaLaTeX; or upgrade your LaTeX distribution and packages}
	\NewInfoField{orcid}{\fbox{O?}\space}[https://orcid.org/]
	\fi
}
\NewInfoField{location}{\cvLocationMarker}
%% Final Add Cabeçalho

% v1.2: Support for multiple photos
\newlength{\altacv@photos@width}
\newlength{\altacv@photo@diam@left}
\newlength{\altacv@photo@diam@right}
\def\altacv@left@photos{}
\def\altacv@right@photos{}

\newcommand{\@makeaphoto}[2]{%
	\begin{minipage}{#1}%
		\if@normalphoto
		\includegraphics[width=\linewidth]{#2}
		\else
		\tikz\path[fill overzoom image={#2}]circle[radius=0.5\linewidth];
		\fi%
	\end{minipage}%
}

\newcommand{\altacv@add@photo@left}[1]{%
	\appto{\altacv@left@photos}{%
		\@makeaphoto{\altacv@photo@diam@left}{#1}\hspace{1ex}%
	}%
	\addtolength{\altacv@photos@width}{\altacv@photo@diam@left}%
	\addtolength{\altacv@photos@width}{1ex}%
}
\newcommand{\altacv@add@photo@right}[1]{%
	\appto{\altacv@right@photos}{%
		\@makeaphoto{\altacv@photo@diam@right}{#1}\hspace{1ex}%
	}%
	\addtolength{\altacv@photos@width}{\altacv@photo@diam@right}%
	\addtolength{\altacv@photos@width}{1ex}%
}
\newcommand{\photoL}[2]{%
	\setlength{\altacv@photo@diam@left}{#1}%
	\forcsvlist{\altacv@add@photo@left}{#2}%
}
\newcommand{\photoR}[2]{%
	\setlength{\altacv@photo@diam@right}{#1}%
	\forcsvlist{\altacv@add@photo@right}{#2}%
}
\let\photo\photoR
% Final Support for multiple photos

%%-----Tamanho Fontes -------------------------------
\newcommand{\namefont}{\Huge\bfseries}
\newcommand{\taglinefont}{\large\bfseries}
\newcommand{\personalinfofont}{\footnotesize\bfseries}
\newcommand{\cvsectionfont}{\LARGE\bfseries}
\newcommand{\cvsectionfontII}{\large\bfseries}
\newcommand{\cvsubsectionfont}{\large\bfseries}
%%-Final Tamanho Fontes -----------------------------

%%-----Bloco criação cabeçalho-----------------------
\newcommand{\makecvheader}{%
  \begingroup
    \altacv@left@photos\hfill%
    \begin{minipage}{\dimexpr\linewidth-\altacv@photos@width}%
    \raggedright%
    {\raggedleft\namefont\color{name}\MakeUppercase{\@name}\par}
    \medskip
    {\raggedleft\taglinefont\color{tagline}\@tagline\par}
    \medskip
    {\personalinfofont\@personalinfo\par}
    \end{minipage}\hfill%
    \altacv@right@photos\par%
  \endgroup\medskip
}

\renewenvironment{quote}{\color{quote}\itshape\normalsize}{\par}
%%-----Final Bloco criação cabeçalho-----------------

%%-----Bloco criação seção---------------------------
\newcommand{\cvsection}[2][]{%
  \bigskip%
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
  {\color{heading}\cvsectionfont\MakeUppercase{#2}}\\[-1ex]%
  {\color{headingrule}\rule{\linewidth}{1pt}\par}\medskip
}

% Novo comando para seção software
\newcommand{\softwarecvsection}[2][]{%
  \bigskip%
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
  {\color{black!70}\cvsectionfontII{#2}}\\[1ex]%
  %{\color{black!70}\rule{\linewidth}{0.5pt}\par}\medskip
}
%%-----FInal Bloco criação seção---------------------

%%-----Bloco criação sub-seção RESUMO-----------------------
\newcommand{\cvsubsectionresumo}[1]{%
  \smallskip%
  \noindent
  \color{subheading}\cvsubsectionfont{#1}%
  \hspace{1ex}%
  \color{headingrule}\rule{0.85\linewidth}{0.5pt}%
  \par\medskip
  \color{resume}\footnotesize\sffamily\fontseries{m}\selectfont
}
%%-----Final Bloco criação sub-seção RESUMO-----------------

%%-----Bloco criação sub-seção-----------------------
\newcommand{\cvsubsection}[1]{%
  \smallskip%
  \noindent
  {\color{subheading}\cvsubsectionfont{#1}\par}\medskip
}


%%-----Bloco criação evento--------------------------
% v1.1.4: fixes inconsistent font size
% v1.7: adds accsupp ActualText for location and date markers
\newcommand{\cvevent}[4]{%
	{\large\color{emphasis}#1\par}
	\smallskip\normalsize
	\ifstrequal{#2}{}{}{
		\textbf{\color{accent}#2}\par
		\smallskip}
	\ifstrequal{#3}{}{}{%
		{\small\makebox[0.5\linewidth][l]%
			{\BeginAccSupp{method=pdfstringdef,ActualText={\datename:}}\cvDateMarker\EndAccSupp{}%
				~#3}%
	}}%
	\ifstrequal{#4}{}{}{%
		{\small\makebox[0.5\linewidth][l]%
			{\BeginAccSupp{method=pdfstringdef,ActualText={\locationname:}}\cvLocationMarker\EndAccSupp{}%
				~#4}%
	}}\par
	\medskip\normalsize
}
%%-----Redefinir evento--------------------------
\makeatletter
\renewcommand{\cvevent}[4]{%
	% linha do cargo
	{\large\color{emphasis}#1\par}%
	% reduzimos o skip entre título e subtítulo
	\vspace{1pt}\normalsize%
	% linha da instituição/status
	\ifstrequal{#2}{}{}{%
		\noindent\textbf{\color{accent}#2}\par
		% pequeno vspace em vez de \smallskip
		\vspace{1pt}%
	}%
	% linha de datas e localização (mantém \small para o ícone+texto)
	\ifstrequal{#3}{}{}{{\footnotesize\makebox[0.5\linewidth][l]{\faCalendar~#3}}}%
	\ifstrequal{#4}{}{}{{\footnotesize\makebox[0.5\linewidth][r]{\faMapMarker~#4}}}\par
	% reduzimos o espaço após a localização
	\vspace{2pt}\normalsize%
}
\makeatother
%%-----Final Bloco criação evento---------------------

%%-----Bloco criação arquivamento---------------------
% v1.7: adds accsupp for the icon as well
\newcommand{\cvachievement}[3]{%
	\begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
		\multirow{2}{*}{\Large\color{accent}\BeginAccSupp{method=escape,ActualText={#1: }}#1\EndAccSupp{}} & \bfseries\textcolor{emphasis}{#2}\\
		& #3
	\end{tabularx}%
	\smallskip
}
%%-----Final Bloco criação arquivamento---------------

%%-----Bloco criação tag------------------------------
\newcommand{\cvtag}[1]{%
	\tikz[baseline]\node[
	anchor=base,
	draw=body!30,
	rounded corners,
	inner xsep=1ex,inner ysep=0.75ex
	]{#1};%
}
%%-----Redefinir tag----------------------------------
\renewcommand{\cvtag}[2][body]{%
	\tikz[baseline]\node[
	anchor=base,
	draw=body!30,        % cor da borda
	rounded corners,     % cantos arredondados
	inner xsep=1ex,      % espaçamento horiz.
	inner ysep=0.75ex,   % espaçamento vert.
	text=#1              % cor do texto/ícone
	]{#2};%
}
%%-----Final Bloco criação tag------------------------

%---------------------------------------------------------
% Bloco criação de tag com categorias  (NÃO conflita com \cvtag)
%---------------------------------------------------------
% ➊  Pré-requisitos
%     \usepackage{tikz}
%---------------------------------------------------------

% ➋ Defina estilos por categoria (cores meramente ilustrativas)
\tikzset{
  % --- já existentes ---
  tag-growth/.style      ={draw=green!60!black ,fill=green!10},
  tag-test/.style        ={draw=blue!60!black  ,fill=blue!10},
  tag-auto/.style        ={draw=orange!70!black,fill=orange!15},
  tag-bi/.style          ={draw=purple!65!black,fill=purple!10},
  tag-eng/.style         ={draw=teal!65!black  ,fill=teal!10},
  tag-comm/.style        ={draw=gray!60!black  ,fill=gray!10},
  % --- novas (pedidas) ---
  tag-analytics/.style   ={draw=cyan!60!black  ,fill=cyan!10},
  tag-experimentacao/.style={draw=yellow!70!black,fill=yellow!10},
  tag-nocode/.style      ={draw=brown!60!black ,fill=brown!10},
  tag-mobile/.style      ={draw=lime!60!black  ,fill=lime!10},
  tag-comunicacao/.style ={draw=magenta!60!black,fill=magenta!10},
  % --- extras de marketing ---
  tag-seo/.style         ={draw=red!60!black   ,fill=red!10},
  tag-sem/.style         ={draw=violet!60!black,fill=violet!10},
  tag-ads/.style         ={draw=blue!70!black  ,fill=blue!15},
  tag-crm/.style         ={draw=orange!60!black,fill=orange!10},
  tag-content/.style     ={draw=green!70!black ,fill=green!15},
  tag-branding/.style    ={draw=purple!70!black,fill=purple!15},
  tag-conversion/.style  ={draw=pink!60!black  ,fill=pink!10},
  tag-social/.style      ={draw=teal!70!black  ,fill=teal!15},
  tag-email/.style       ={draw=brown!70!black ,fill=brown!15},
  tag-ux/.style          ={draw=gray!70!black  ,fill=gray!15},
  % --- fallback ---
  tag-default/.style     ={draw=body!30        ,fill=body!05}
}

% ➌ Novo comando   \cvtagcat[<categoria>]{<conteúdo>}
%    • Mantém a sintaxe opcional da categoria
%    • Deixa seu \cvtag original intacto
\newcommand{\cvtagcat}[2][]{%
  \tikz[baseline]\node[
    anchor=base,
    rounded corners,
    inner xsep=1ex,
    inner ysep=0.75ex,
    font=\small,
    tag-default,   % garante borda/padding padrão
    tag-#1         % sobrepõe se houver categoria
  ]{#2};%
}

%%-----Bloco criação skill----------------------------
% v1.6: Use accsupp so that the actual numeric value is copied/pasted
%       and also support 0.5, 1.5, 2.5, 3.5, 4.5
\newcommand{\cvskill}[3]{% idioma, descrição, nível (0 a 5)
  \textbf{\textcolor{emphasis}{#1}}%
  \ifthenelse{\equal{#2}{}}{}{ {\scriptsize -- #2}}%
  \hfill
  \BeginAccSupp{method=plain,ActualText={#3}}
  \foreach \x in {1,...,5}{%
    \ifdimequal{\x pt - #3 pt}{0.5pt}{%
      \tikz[baseline]{\draw[fill=accent!80!white,draw=none] (0,0) circle (3pt);}%
    }{%
      \ifdimgreater{\x bp}{#3 bp}{%
        \tikz[baseline]{\draw[fill=gray!30,draw=none] (0,0) circle (4pt);}%
      }{%
        \tikz[baseline]{\draw[fill=accent,draw=none] (0,0) circle (4pt);}%
      }%
    }%
    \hspace{0.5em}%
  }%
  \EndAccSupp\par
}
%%-----Final Bloco criação skill-----------------------

% Adapted from @Jake's answer at http://tex.stackexchange.com/a/82729/226
\newcommand{\wheelchart}[4][0]{%
	\begingroup\centering
	\def\innerradius{#3}%
	\def\outerradius{#2}%
	% Calculate total
	\pgfmathsetmacro{\totalnum}{0}%
	\foreach \value/\colour/\name in {#4} {%
		\pgfmathparse{\value+\totalnum}%
		\global\let\totalnum=\pgfmathresult%
	}%
	\begin{tikzpicture}

		% Calculate the thickness and the middle line of the wheel
		\pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
		\pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
		\pgfmathsetmacro{\totalrot}{-90 + #1}

		% Rotate so we start from the top
		\begin{scope}[rotate=\totalrot]

			% Loop through each value set. \cumnum keeps track of where we are in the wheel
			\pgfmathsetmacro{\cumnum}{0}
			\foreach \value/\width/\colour/\name in {#4} {
				\pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}

				% Calculate the percent value
				\pgfmathsetmacro{\percentage}{\value/\totalnum*100}
				% Calculate the mid angle of the colour segments to place the labels
				\pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}

				% This is necessary for the labels to align nicely
				\pgfmathparse{
					(-\midangle>180?"west":"east")
				} \edef\textanchor{\pgfmathresult}
				\pgfmathparse{
					(-\midangle>180?"flush left":"flush right")
				} \edef\textalign{\pgfmathresult}
				\pgfmathsetmacro\labelshiftdir{1-2*(-\midangle<180)}

				% Draw the color segments. Somehow, the \midrow units got lost, so we add 'pt' at the end. Not nice...
				\filldraw[draw=white,fill=\colour] (-\cumnum:\outerradius) arc (-\cumnum:-(\newcumnum):\outerradius) --
				(-\newcumnum:\innerradius) arc (-\newcumnum:-(\cumnum):\innerradius) -- cycle;

				% Draw the data labels
				% v1.6: Use accsupp so that the numeric number is copied/pasted too
				\draw  [*-,thin,emphasis] node [append after command={(\midangle:\midradius pt) -- (\midangle:\outerradius + 1ex) -- (\tikzlastnode)}] at (\midangle:\outerradius + 1ex) [xshift=\labelshiftdir*0.5cm,inner sep=1ex, outer sep=0pt, text width=\width,anchor=\textanchor,align=\textalign,font=\small,text=body]{\BeginAccSupp{method=pdfstringdef,ActualText={\name: \value}}\name\EndAccSupp{}};
				% Set the old cumulated angle to the new value
				\global\let\cumnum=\newcumnum
			}
		\end{scope}
		%      \draw[gray] (0,0) circle (\outerradius) circle (\innerradius);
	\end{tikzpicture}\par
	\endgroup
}


\newcommand{\cvref}[3]{%
  \smallskip
  \textcolor{emphasis}{\textbf{#1}}\par
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.35em,align=left]
  \item[\small\normalfont\emailsymbol] #2
  \item[\small\normalfont\mailaddresssymbol] #3
  \end{description}
%   \medskip
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}

% v1.5 Move biblatex-related code to separate .cfg file
% so that it's easier to change and customise the style for
% publication lists

% v1.1.2: make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

% v1.6.5 But provide for ability to highlight names in publication list
\RequirePackage{pgffor}
\def\my@namelist{}
\newcommand{\mynames}[1]{\def\my@namelist{#1}}
\newtoggle{boldname}
% v1.7.3 For backward compatibility re hooks management
\IfFormatAtLeastTF{2021-11-15}{%
	\AddToHook{package/biblatex/after}{%
		\typeout{OK AddToHook biblatex after works}
		\altacv@makeboldnames
	}%
}{%
	\AfterPackage{biblatex}{%
		\typeout{OK AfterPackage biblatex after works}
		\altacv@makeboldnames
	}%
}



% 1.7.3 Backward compatibility for hooks management
\IfFormatAtLeastTF{2020-10-01}{%
	\AddToHook{begindocument/before}{%
		\pagestyle{empty}%
		\color{body}%
		\raggedright%
	}
}{%
	\AtBeginDocument{%
		\pagestyle{empty}%
		\color{body}%
		\raggedright%
	}
}

%##############################################################################################################################

%\newcommand{\barskill}[3]{
	% remove 1pt in width to prevent overfull box warnings
%	\begin{tikzpicture}[x=\sidebartextwidth-1pt, y=2ex]
%		\draw[fill, skillbg, rounded corners=0.5em]	(0, 0) rectangle (1, 1);
%		\draw[fill, iconcolor!70, rounded corners=0.5em] (0, 0) rectangle (#3/100, 1);
%		\node[above right] at (0, 1) {\cvicon{#1} ~ #2};
%	\end{tikzpicture}
%	\par
%}

%\begin{tikzpicture}
%	\node [anchor=west] at (.1,.8) {Java};
%	\draw [fill=gray] (0,0) rectangle (5,.5);
%	\draw [fill={rgb:red,1;green,2;blue,3}] (0,0) rectangle (.1,.5);
%\end{tikzpicture}

\newcommand\barskills[1]{
	\begin{tikzpicture}
		\foreach [count=\i] \x/\y in {#1}{
			\draw[fill=body!30,body!30, rounded corners=0.4em] (0,\i) rectangle (5,\i+0.3);
			\draw[fill, accent, rounded corners=0.4em](0,\i) rectangle (\y,\i+0.3);
			\node[above right] at (0,\i+0.3) {\x};
		}
	\end{tikzpicture}
}



%#######################

% Estas linhas referência garantir emoji na tela
\usepackage{stringenc,graphicx}

\makeatletter
\newcommand{\gethex}[1]{%
	\StringEncodingConvert{\gh@tmp}{\detokenize{#1}}{utf8}{utf32}%
	\edef\gh@tmp{\pdfescapehex\expandafter{\gh@tmp}}%
	\expandafter\get@hex\gh@tmp\get@hex
}
\def\get@hex#1{%
	\if0#1%
	\expandafter\@firstoftwo
	\else
	\expandafter\@secondoftwo
	\fi
	{\get@hex}{\get@hex@aux#1}%
}
\def\get@hex@aux#1\get@hex{%
	\def\gh@string{#1}%
}
\newcommand{\coloremoji}[2][]{%
	\gethex{#2}%
	\includegraphics[#1]{emoji_images/hires/\gh@string.pdf}%
}
\makeatother

%-----------------------------------------------------------

\usepackage{scalerel,xparse}
\NewDocumentCommand\emojismile{}{
	\scalerel*{
		\includegraphics{Conteúdo/EmojiFolder/u1F60A.png}
	}{X}
}
\NewDocumentCommand\emojismiley{}{
	\includegraphics[scale=0.05]{Conteúdo/EmojiFolder/u1F60A.png}
}

\NewDocumentCommand\holanda{}{
	\includegraphics[scale=0.05]{Conteúdo/EmojiFolder/u1F1F1_u1F1FA.png}
}
\NewDocumentCommand\espanha{}{
	\includegraphics[scale=0.05]{Conteúdo/EmojiFolder/u1F1EA_u1F1F8.png}
}
\NewDocumentCommand\brasil{}{
	\includegraphics[scale=0.05]{Conteúdo/EmojiFolder/u1F1E7_u1F1F7.png}
}
\NewDocumentCommand\usa{}{
	\includegraphics[scale=0.05]{Conteúdo/EmojiFolder/u1F1FA_u1F1F8.png}
}
\NewDocumentCommand\apontar{}{
	\includegraphics[scale=0.05]{Conteúdo/EmojiFolder/u1F90F.3.png}
}

%------------------------------------------------------------

\pagestyle{empty}

%------------------------------------------------------------

\graphicspath{{/home/dns/Downloads/Analista_de_Marketing/Conteúdo/Imagem/}}

%------------------------------------------------------------%
% TESTE SEM CORES - substitua o bloco original por:

\NewEnviron{commentA}{}
\newcommand\Aon{\RenewEnviron{commentA}{\BODY}}
\newcommand\Aoff{\RenewEnviron{commentA}{}}

\NewEnviron{commentB}{}
\newcommand\Bon{\RenewEnviron{commentB}{\BODY}}
\newcommand\Boff{\RenewEnviron{commentB}{}}

\NewEnviron{commentC}{}
\newcommand\Con{\RenewEnviron{commentC}{\BODY}}
\newcommand\Coff{\RenewEnviron{commentC}{}}

\NewEnviron{commentD}{}
\newcommand\Don{\RenewEnviron{commentD}{\BODY}}
\newcommand\Doff{\RenewEnviron{commentD}{}}

\NewEnviron{commentE}{}
\newcommand\Eon{\RenewEnviron{commentE}{\BODY}}
\newcommand\Eoff{\RenewEnviron{commentE}{}}

\NewEnviron{commentF}{}
\newcommand\Fon{\RenewEnviron{commentF}{\BODY}}
\newcommand\Foff{\RenewEnviron{commentF}{}}

\NewEnviron{commentG}{}
\newcommand\Gon{\RenewEnviron{commentG}{\BODY}}
\newcommand\Goff{\RenewEnviron{commentG}{}}

\NewEnviron{commentH}{}
\newcommand\Hon{\RenewEnviron{commentH}{\BODY}}
\newcommand\Hoff{\RenewEnviron{commentH}{}}

\NewEnviron{commentI}{}
\newcommand\Ion{\RenewEnviron{commentI}{\BODY}}
\newcommand\Ioff{\RenewEnviron{commentI}{}}

%------------------------------------------------------------%
\usepackage{ifthen}  % Adicione se não estiver presente

% Ambiente para controlar qual profissão mostrar
\NewEnviron{profissao}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual cabeçalho mostrar
\NewEnviron{cabecalho}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual resumo mostrar
\NewEnviron{resumo}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual formação mostrar
\NewEnviron{formacao}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual experiência profissional mostrar
\NewEnviron{profissional}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual mensagem mostrar
\NewEnviron{mensagem}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual mensagem mostrar
\NewEnviron{mensagens}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual habilidade mostrar
\NewEnviron{habilidade}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual competência mostrar
\NewEnviron{competencia}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual idioma mostrar
\NewEnviron{idioma}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual certificações mostrar
\NewEnviron{certificado}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual cursos mostrar
\NewEnviron{curso}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual internacional mostrar
\NewEnviron{internacional}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual meu dia mostrar
\NewEnviron{meu}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual software dia mostrar
\NewEnviron{software}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual carta de apresentação mostrar
\NewEnviron{carta}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

% Ambiente para controlar qual competência pessoal mostrar
\NewEnviron{pessoal}[1]{%
    \ifthenelse{\equal{#1}{A}}{\Aon\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{B}}{\Aoff\Bon\Coff\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{C}}{\Aoff\Boff\Con\Doff\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{D}}{\Aoff\Boff\Coff\Don\Eoff\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{E}}{\Aoff\Boff\Coff\Doff\Eon\Foff\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{F}}{\Aoff\Boff\Coff\Doff\Eoff\Fon\Goff\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{G}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Gon\Hoff\Ioff}{}%
    \ifthenelse{\equal{#1}{H}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hon\Ioff}{}%
    \ifthenelse{\equal{#1}{I}}{\Aoff\Boff\Coff\Doff\Eoff\Foff\Goff\Hoff\Ion}{}%
    \BODY
}

\RenewDocumentCommand{\cvtag}{O{body}m}{%
	\tikz[baseline]\node[
	anchor=base,
	draw=body!30,                % borda cinza-claro
	rounded corners,             % cantos arredondados
	inner xsep=1ex,              % espaçamento interno horizontal
	inner ysep=0.75ex,           % vertical
	text=#1                      % cor do texto/ícone
	% <!-- note que NÃO há 'fill' aqui -->
	]{#2};%
}

\newcommand{\cvitemize}[1]{%
  \begin{list}{\labelitemi}{%
    \setlength{\leftmargin}{1em}%
    \setlength{\itemsep}{0.3em}%
    \setlength{\topsep}{0.3em}%
    \setlength{\parsep}{0pt}%
    \setlength{\partopsep}{0pt}%
  }%
  {\footnotesize #1}%
  \end{list}%
}

\newcommand{\cviconitemize}[1]{%
  \begin{itemize}[nosep,
    labelwidth=1.8em,
    labelsep=0.5em,
    leftmargin=!,
    itemsep=3pt,
    topsep=0pt,
    parsep=0pt,
    partopsep=0pt,
    before=\footnotesize,
    font=\footnotesize
  ]
  #1
  \end{itemize}
}

\newcommand{\faicon}[1]{{\fontsize{7}{7}\selectfont#1}}
