package Qt::QHBoxLayout;
use parent 'Qt::QAbstractBoxLayout';
 
use strict;
use warnings;

use strict;
use Gtk2;

=pod

=head1 B<Qt::QHBoxLayout>

=head2 DESCRIPTION

QHBoxLayout is for horizontal layout.

=head2 EXAMPLE

    my $layout = QHBoxLayout();
    $layout->addWidget($button1);
    $layout->addWidget($button2);
    
    my $widget = QWidget();
    $widget->setLayout($layout);    

=cut

sub new {
    my $class = shift;
    my $self = $class->SUPER::new('QHBoxLayout');
    $self->attach(Gtk2::HBox->new (0,$self->{'spacing'})); 
    $self->{'direction'} = 'H';
    return $self;
}


1;


