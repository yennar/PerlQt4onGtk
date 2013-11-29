package Qt::QAbstractList;
use parent 'Qt::QAbstractObject';

use strict;
use warnings;
use Data::Dumper;

sub new {
    my $class = shift;
    my $child_class_name = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->add_meta($child_class_name);
    $self->init();
    return $self;
}

sub init {
    my $self = shift;
    $self->{collection_children_obj} = {};
    $self->{collection_children_list} = [];  
    $self->{collection_id} = {};
}

sub list {
    my $self = shift;
    my $rtn = [];
    my $new_list = [];
    foreach (@{$self->{collection_children_list}}) {
        push @$new_list,$_;
    }
    return $new_list;     
}

sub iter {
    my $self = shift;
    my $id_to_find = shift;
    return undef if (!defined $id_to_find);
    return undef if (!defined $id_to_find || $id_to_find == -1 || !defined $self->{collection_id}->{$id_to_find});    
    return $self->{collection_children_obj}->{$id_to_find};    
}

sub size {
    my $self = shift;
    return scalar(@{$self->{collection_children_list}});
}

sub at {
    my $self = shift;
    my $pos_to_find = shift;
    
    return undef if (!defined $pos_to_find);
    my $id_to_find = $self->_id_by_pos($pos_to_find);
    return undef if (!defined $id_to_find || $id_to_find == -1);    
    return $self->{collection_children_obj}->{$id_to_find};
}

sub append {
    my $self = shift;
    my $obj = shift;
    return -1 if (!defined $obj);
    
    my $id = $self->_get_id();
    $self->{collection_children_obj}->{$id} = $obj;
    push @{$self->{collection_children_list}},$id;
    return $id;
}

sub remove {
    my $self = shift;
    my $obj = shift;
    
    return undef if (!defined $obj);
    
    if (ref($obj) eq '' && $obj =~ /^\d+$/) {
        $obj = $self->{collection_children_obj}->{$obj};
        return $self->_remove($obj);
    } else {
        return $self->_remove($obj);
    }
    
    return undef; 
}

sub _remove {
    my $self = shift;
    my $obj = shift;
    return undef if (!defined $obj);
    my $remove_list = {};
    
    foreach (keys %{$self->{collection_children_obj}}) {
        my $id = $_;
        my $o = $self->{collection_children_obj}->{$id};
        
        if ($o eq $obj) {
           $remove_list->{$id} = 1;  
        }
    }
    
    my $new_list = [];
    foreach (@{$self->{collection_children_list}}) {
        my $id = $_;
        if (defined $remove_list->{$id}) {
            delete $self->{collection_children_obj}->{$id};
            $self->{collection_id}->{$id} = 0;
        } else {
            push @$new_list,$id;
        }
    }
    
    $self->{collection_children_list} = $new_list;
    my @remove_list = keys %$remove_list;
    return \@remove_list;
}

sub insert {
    my $self = shift;
    my $after = shift;
    my $obj = shift;
    
    return undef if (!defined $after);
    
    if ($self->size() == 0) {
        $self->append($obj);
    } else {
    
        if (ref($after) eq '' && $after =~ /^\d+$/) {
            return $self->_insert_by_pos($after,$obj);
        } else {
            return $self->_insert_by_obj($after,$obj);
        }
    }
    return undef; 
}

sub _id_by_pos {
    my $self = shift;
    my $pos_to_find = shift;

    my $id_to_find = -1;
    
    return -1 if (!defined $pos_to_find);
    return -1 if (!($pos_to_find =~ /^\d+$/));
    return -1 if ($pos_to_find < 0 || $pos_to_find >= $self->size());
    
    my $pos = 0;
    foreach (@{$self->{collection_children_list}}) {
        my $id = $_;       
        if ($pos == $pos_to_find) {
           $id_to_find = $id;
           last; 
        }
        $pos ++;
    }    
    return $id_to_find;
}

sub _insert_by_pos {
    my $self = shift;
    my $after_pos= shift;
    my $obj = shift;
    
    
    return undef if (!defined $after_pos);
    return undef if (!defined $obj);
    
    my $after_id = $self->_id_by_pos($after_pos);
    
    return undef if ($after_id == -1);
    return $self->_insert_by_id($after_id,$obj);
}

sub _insert_by_obj {
    my $self = shift;
    my $after = shift;
    my $obj = shift;
    
    return undef if (!defined $after);
    return undef if (!defined $obj);
    
    my $after_id = -1;
    
    foreach (keys %{$self->{collection_children_obj}}) {
        my $id = $_;
        my $o = $self->{collection_children_obj}->{$id};
        
        if ($o eq $after) {
           $after_id = $id;
           last; 
        }
    }
    
    return undef if ($after_id == -1);
    return $self->_insert_by_id($after_id,$obj);
}

sub _insert_by_id {
    my $self = shift;
    my $after_id = shift;
    my $obj = shift;
    
    return undef if (!defined $after_id);
    return undef if (!defined $obj);
    
    my $new_list = [];
    my $new_id = -1;
    foreach (@{$self->{collection_children_list}}) {
        my $id = $_;
        push @$new_list,$id;
        
        if ($id == $after_id) {
            $new_id = $self->_get_id();
            $self->{collection_children_obj}->{$new_id} = $obj;
            push @$new_list,$new_id;
        }

    }
    
    $self->{collection_children_list} = $new_list;
    return $new_id;
}

sub _get_id {
    my $self = shift;
    # find an unused id
    my $id_found = -1;
    my $id_max = -1;
    
    foreach (keys %{$self->{collection_id}}) {
        if ($_ > $id_max) {
            $id_max = $_;
        }
        if ($self->{collection_id}->{$_} == 0) {
            $id_found = $_;
        }
    }
    
    if ($id_found == -1) {
        $id_max ++;
        $id_found = $id_max;
    }
    
    $self->{collection_id}->{$id_found} = 1;
    return $id_found;
}

sub _print {
    my $self = shift;
    foreach (@{$self->{collection_children_list}}) {
        my $id = $_;
        my $o = $self->{collection_children_obj}->{$id};
        $o->_print();
        print "\n";
    }
    print "\n";
}

1;


