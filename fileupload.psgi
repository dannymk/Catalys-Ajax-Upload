use strict;
use warnings;

use FileUpload;

my $app = FileUpload->apply_default_middlewares(FileUpload->psgi_app);
$app;

