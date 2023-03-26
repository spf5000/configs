let
  sean_user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMKaZjlLVwV1FS/CEjHlo50dpsZTCyvSwzYY1OFp3eS";
  users = [ sean_user ];

  rpi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9Cx+08doFFcDs6Rt6NMxOqIjGHRjjk2KEpG67rJZ2X";
  systems = [ rpi ];
in
{
  "ddnsToken.agenix".publicKeys = [ sean_user rpi ];
  "userPass.agenix".publicKeys = [ sean_user rpi ];
}
