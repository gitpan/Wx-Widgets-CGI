# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Wx::Widgets::CGI;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.


# [XXX: change into tests rather than a demo]

use strict;
MyApp->new()->MainLoop();

package MyApp;
use base qw(Wx::App);
use Wx qw(:everything);
use lib qw(./blib/lib);
use Wx::Widgets::CGI;

our %labels = (
    red => 'Red',
    green => 'Green',
    blue => 'Blue',
);

sub OnInit {
    my $self = shift;
    my ($frame, $q, $pagesizer, $rowsizer, $control, $control2);

    $frame = Wx::Frame->new(
        undef, -1, 'Test', wxDefaultPosition, wxSIZE(400,500)
    );
    $frame->SetAutoLayout(1);

    $q = Wx::Widgets::CGI->new(-parent => $frame);

    $pagesizer = Wx::BoxSizer->new(wxVERTICAL);

    # can use `print' to add the control to the pager
    $q->print($q->h1('H1 text'), $pagesizer);
    $q->print($q->h2('H2 text'), $pagesizer);
    $q->print($q->h3('H3 text'), $pagesizer);
    # or `print' an array ref of controls
    $q->print([$q->h4('H6 text'), $q->h5('H6 text'), $q->h6('H6 text')],
              $pagesizer);

    $rowsizer = Wx::BoxSizer->new(wxHORIZONTAL);
    # or `print' StaticText
    $rowsizer->Add($q->print('Textfield: '));
    $control = $q->textfield(
        -name => 'color_textfield',
        -default => 'blue',
        -size => 50,         # window width, not number of chars
        -maxlength => 30,
    );
    # (can still use Add if you want)
    $rowsizer->Add($control);
    $pagesizer->Add($rowsizer);


    $rowsizer = Wx::BoxSizer->new(wxHORIZONTAL);

    $control = $q->password_field(
        -name => 'color_password',
        -value => 'blue',
        -size => 50,         # window width, not number of chars
        -maxlength => 30,
    );
    $q->print([$q->print('Password: '), $control], $rowsizer);

    $pagesizer->Add($rowsizer);

    $control = $q->textarea(
        -name => 'color_area',
        -default => 'I like colors!',
        -rows => 100,        # window height, not number of rows
        -columns => 200,     # column width, not number of chars
    );
    $q->print($control, $pagesizer);

    $rowsizer = Wx::BoxSizer->new(wxHORIZONTAL);

    $control = $q->popup_menu(
        -name => 'color_popup',
        -values => ['red', 'green', 'blue'],
        -default => 'green',
        -labels => \%labels,
    );

    $control2 = $q->scrolling_list(
        -name => 'color_list',
        -values => ['red', 'green', 'blue'],
        -default => 'green',
        -size => 40,           # window height, not number of rows
        -multiple => 1,
        -labels => \%labels,
    );
    $q->print([$control, $control2], $rowsizer);
    $pagesizer->Add($rowsizer);

#    $q->checkbox_group(
#        -name => 'color_checkbox_group',
#        -values => ['red', 'green', 'blue', 'yellow'],
#        -default => 'green',
#        -linebreak => 'true',
#        -labels => \%labels,
#        -nolabels => undef,
#        -rows => 2,
#        -columns => 2,
#        -rowheaders => undef,
#        -colheaders => undef,
#    );

    $rowsizer = Wx::BoxSizer->new(wxHORIZONTAL);

    $control = $q->checkbox(
        -name => 'color_checkbox',
        -checked => 'checked',
        -label => 'CLICK ME',
    );

    $control2 = $q->radio_group(
        -name => 'color_radio_group',
        -values => ['red', 'green', 'blue'],
        -default => 'green',
        -linebreak => 'true',
        -labels => \%labels,
        -nolabels => 0,
        -rows => 2,
        -cols => 2,
#        -rowheaders => undef,         # unimplemented
#        -colheaders => undef,         # unimplemented
        -caption => 'Color?',         # not originally in CGI
    );
    $q->print([$control, $control2], $rowsizer);
    $pagesizer->Add($rowsizer);

    $rowsizer = Wx::BoxSizer->new(wxHORIZONTAL);

    $control = $q->submit(
        -name => 'color_button',
        -value => 'submit-esque',
    );

    $control2 = $q->image_button(
        -name => 'button_name',
        -src => './save.xpm',
    );
    $q->print([$control, $control2], $rowsizer);
    $pagesizer->Add($rowsizer);

    print "PARAM VALUES:\n";
    foreach my $param ($q->param()) {
        print $param, ': ', $q->param($param), $/;
    }


    $frame->SetSizer($pagesizer);
    $pagesizer->SetSizeHints($frame);

    $self->SetTopWindow($frame);
    $frame->Show(1);
}


1;
