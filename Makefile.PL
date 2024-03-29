use 5.006;

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Wx::Widgets::CGI',
    'VERSION_FROM'	=> 'CGI.pm', # finds $VERSION
    'PREREQ_PM'		=> {
        'Wx' => 0,
    },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'CGI.pm', # retrieve abstract from module
       AUTHOR     => 'Scott Lanning <slanning@theworld.com>') : ()),
);
