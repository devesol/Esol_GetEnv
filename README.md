NAME
    Esol::GetEnv - extract the environment value from /etc/environment

SYNOPSIS
      use Esol::GetEnv;

      $env = getenv('myEnv');
      
DESCRIPTION
    Esol::GetEnv provides a facility for obtaining values of variable ENV as getenv of php do.
    With php you can access with getenv to : 
    - system variable Env $_ENV["PATH"]
    - variable Env defined in /etc/environment
    - variable Env defined in envvars of apache config files
  
    with perl you can only acces to system variable Env with following syntax : 
    $path = $ENV{'PATH'}; 
    
METHODS
    getenv
          $path = getenv('PATH');
          

  EXPORT
    getenv

SEE ALSO

DEPENDENCIES
    The Strict module is required
    
AUTHOR
    Cédric DELAMARRE, <cdelamarre@gmail.com>

CONTRIBUTORS
    Cédric DELAMARRE, <cdelamarre@gmail.com>

COPYRIGHT AND LICENSE
    Copyright 2017 E-Solutions SAS

    This software is released under the GNU General Public License. You may
    find a copy at

              http://www.gnu.org/licenses

