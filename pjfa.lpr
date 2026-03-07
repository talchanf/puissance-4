program pjfa;

uses
  Crt;

type
  Tableau = array[1..6,1..7] of integer; // Pour pouvoir passer le tableau dans les paramètres de la procédure

var
  rep,c, randPos:integer;
  t: Tableau; // plateau de jeux
  v: boolean; // statue du jeu
  cp: array of integer; // coup possible
  replay: string;


PROCEDURE initGame();
var i, j : integer;
begin
  for i := 0 to length(t) do
  begin
    for j := 0 to length(t[i]) do
    begin
      t[i][j] := 0;
    end;
  end;
  setLength(cp,7);
  for i := 0 to length(cp)-1 do
  begin
    cp[i] := i + 1;
  end;
  v := true;
end;

PROCEDURE writeGameboard();
   {entête de la procédure}
var i, j, k : integer;
   {déclarations procédure}
begin
  {corps de la procédure}
  for i := 1 to length(t) do
  begin
    for j := 1 to length(t[i]) do
    begin
        if (t[i][j]=0) then
        begin
            write('*     ');
        end
                         else
        begin
          write(t[i][j],'     ');
        end;
    end;
    writeln;
  end;
  for k := 1 to 7 do write('[',k,']   ');
  writeln;
  writeln;
end;

FUNCTION getPos(var e: Integer; tab: array of integer): Integer;
var
  i: Integer;
begin
  getPos := -1; // Initialiser à -1 si l'élément n'est pas trouvé
  for i := 0 to high(tab) do
  begin
    if tab[i] = e then
    begin
      getPos := i;
      Break; // Sortir de la boucle dès que l'élément est trouvé
    end;
  end;
end;

PROCEDURE delete(var tab: array of integer; index: integer);
var
  i: integer;
begin
  // Décaler tous les éléments suivants d'une position vers la gauche
  for i := index to high(tab) do
    tab[i] := tab[i + 1];

  setLength(cp, length(tab)-1);
end;

FUNCTION checkWin(): Boolean;
var i, j : integer;
begin
  for i := 0 to length(t) do
  begin
    for j := 0 to length(t[i]) do
    begin

      if(t[i][j]=0) then
      begin
        continue;
      end;

      if(((t[i][j]=t[i+1][j]) and (t[i][j]=t[i+2][j]) and (t[i][j]=t[i+3][j])) // Vérification verticale
      or ((t[i][j]=t[i][j+1]) and (t[i][j]=t[i][j+2]) and (t[i][j]=t[i][j+3])) // Vérification horizontale
      or ((t[i][j]=t[i-1][j+1]) and (t[i][j]=t[i-2][j+2]) and (t[i][j]=t[i-3][j+3]))  // Vérification diagonale descendante (\)
      or ((t[i][j]=t[i+1][j+1]) and (t[i][j]=t[i+2][j+2]) and (t[i][j]=t[i+3][j+3]))) then  // Vérification diagonale montante (/)
      begin
        ClrScr;
        writeGameboard;
        Result := true;
        Exit;
      end;
    end;
  end;
  Result := false;

end;

PROCEDURE playCoup(var c:integer; player:integer);
var l,pos:integer;
begin
  l := length(t);
  while (l >= 1) do
  begin
    if (t[l][c]=0) then
    begin
      t[l][c] := player;
      if (l=1) then
      begin
        pos := getPos(c, cp);
        delete(cp, pos);
      end;
      Exit;
    end;
    l := l-1;
  end;
end;

FUNCTION checkCoupPossible (var c : integer; cp : array of integer): Boolean;
var coup: Integer;
begin
  for coup in cp do
    if coup = c then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;


begin
  repeat
    ClrScr;
    writeln('---------------');
    writeln('| PUISSANCE 4 |');
    writeln('---------------');
    writeln;
    writeln('[1] - Jouer contre l''ia');
    writeln('[2] - Jouer en local');
    writeln('[3] - Regles du jeu');
    writeln('[4] - Strategies');
    writeln('[5] - Quitter le jeu');
    writeln;
    readln(rep);
    if(rep=1) then
    begin
      repeat
        // Initialisation du jeu
        initGame;
        while (v=true) do
        begin
          ClrScr;
          writeGameboard;

          //Vérification d'une potentielle égalité
          if(Length(cp)=0) then
          begin
            writeln('Egalite! Partie terminee.');
            v:=false;
            break;
          end;

          // au tour du joueur 1
          writeln('A toi de jouer!');
          writeln('Choisis une colonne entre 1 et 7');
          readln(c);
          while (not checkCoupPossible(c, cp)) do
          begin
            writeln('Coup impossible! Veuillez rejouer!');
            readln(c);
          end;
          playCoup(c, 1);
          if(checkWin) then
          begin
            writeln('Vous gagnez!');
            v:=false;
            break;
          end;

          // au tour de l'ia
          randPos := Random(length(cp));
          c := cp[randPos]; // Récupère l'une des colonnes restantes aléatoirement
          playCoup(c, 2);
          if(checkWin) then
          begin
            writeln('l''ia gagne!');
            v:=false;
            break;
          end;
        end;
        writeln('Voulez-vous rejouer? (y-n)');
        readln(replay);
      until (replay <> 'y');
    end;

    if(rep=2) then
    begin
      repeat
        // Initialisation du jeu
        initGame;
        while (v=true) do
        begin
          ClrScr;
          writeGameboard;

          //Vérification d'une potentielle égalité
          if(Length(cp)=0) then
          begin
            writeln('Egalite! Partie terminee.');
            v:=false;
            break;
          end;

          // au tour du joueur 1
          writeln('Au tour du joueur 1!');
          readln(c);
          while (not checkCoupPossible(c, cp)) do
          begin
            writeln('Coup impossible! Veuillez rejouer!');
            readln(c);
          end;
          playCoup(c, 1);
          if(checkWin) then
          begin
            writeln('Le joueur 1 gagne!');
            v:=false;
            break;
          end;

          // au tour du joueur 2
          ClrScr;
          writeGameboard;
          writeln('Au tour du joueur 2!');
          readln(c);
          while (not checkCoupPossible(c, cp)) do
          begin
            writeln('Coup impossible! Veuillez rejouer!');
            readln(c);
          end;
          playCoup(c, 2);
          if(checkWin) then
          begin
            writeln('le joueur 2 gagne!');
            v:=false;
            break;
          end;
        end;
        writeln('Voulez-vous rejouer? (y-n)');
        readln(replay);
      until (replay <> 'y');
    end;
    if(rep=3) then
    begin
      // Ecrire les règles du jeu
      ClrScr;
      writeln('Voici les regles du jeu:');
      writeln;
      writeln('Pour jouer, rien de plus simple. Tout d''abord, vous devez choisir si vous voulez jouer contre une ia ou contre');
      writeln('un autre utilisateur en local. Ensuite, il vous suffira d''ecrire en chiffre la colonne ou vous souhaitez mettre');
      writeln('votre jeton.');
      writeln;
      writeln('Pour gagner, il suffit d''aligner 4 jetons horizatonlement, verticalement ou diagonalement avant le joueur d''en face.');
      writeln;
      writeln;
      writeln('Appuyez sur la touche "entree" pour revenir au menu. ');
      readln;
    end;
    if (rep=4) then
    begin
      // Ecrire les stratégies
      Clrscr;
      writeln('Voici les stategies:');
      writeln;
      writeln('Il faut d''abord placer ses jetons au centre pour avoir un controle des espaces et ainsi augmenter ses chances de liaisons pour les prochains coups.');
      writeln('Ensuite, faites attention aux jetons du joueur d''en face, bloquer le a tout pris.Vous pouvez meme vous servir de leur position pour faciliter la possibilitee de liaison entre vos jetons.');
      writeln;
      writeln;
      writeln('Appuyez sur la touche "entree" pour revenir au menu. ');
      readln;
    end;

  until (rep = 5);

  Halt;
end.



