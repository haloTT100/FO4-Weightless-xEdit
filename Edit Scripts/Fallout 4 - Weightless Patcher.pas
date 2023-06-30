(*
	Author: haloTT100
	Based on Predence's script (https://www.nexusmods.com/skyrimspecialedition/mods/749)
	Credits to him
*)
unit UserScript;

uses 'lib\mxpf';

var
  i, anim: Integer;
  signature: String;
  originalWeight, newWeight: Real;
  rec: IInterface;
  alchPatch, ammoPatch, armorPatch, bookPatch, miscPatch, keymPatch, notePatch, weaponPatch, grenadePatch: Boolean;

	
function Initialize: Integer;
begin
	DefaultOptionsMXPF;
	InitializeMXPF;
	
	alchPatch := StringToBool(InputBox('Do you want to make foods/ingredients weightless?', 'Input true or false:','')) = True;
	ammoPatch := StringToBool(InputBox('Do you want to make ammunitions weightless?', 'Input true or false:','')) = True;
	armorPatch := StringToBool(InputBox('Do you want to make armors weightless?', 'Input true or false:','')) = True;
	bookPatch := StringToBool(InputBox('Do you want to make books weightless?', 'Input true or false:','')) = True;
	miscPatch := StringToBool(InputBox('Do you want to make miscellaneous items weightless?', 'Input true or false:','')) = True;
	keymPatch := StringToBool(InputBox('Do you want to make keys weightless?', 'Input true or false:','')) = True;
	notePatch := StringToBool(InputBox('Do you want to make notes weightless?', 'Input true or false:','')) = True;
	weaponPatch := StringToBool(InputBox('Do you want to make weapons weightless?', 'Input true or false:','')) = True;
	if (not weaponPatch) then
		grenadePatch := StringToBool(InputBox('Do you want to make grenades weightless?', 'Input true or false:','')) = True;
	
	PatchFileByName('WeightLess.esp');

	if alchPatch then
	begin
		AddMessage('Loading ALCHEMY patch');
		LoadRecords('ALCH');
	end;

	if ammoPatch then
	begin
		AddMessage('Loading AMMO patch');
		LoadRecords('AMMO');
	end;

	if armorPatch then
	begin
		AddMessage('Loading ARMOR patch');
		LoadRecords('ARMO');
	end;

	if bookPatch then
	begin
		AddMessage('Loading BOOK patch');
		LoadRecords('BOOK');
	end;

	if miscPatch then
	begin
		AddMessage('Loading MISC patch');
		LoadRecords('MISC');
	end;

	if keymPatch then
	begin
		AddMessage('Loading KEYM patch');
		LoadRecords('KEYM');
	end;

	if notePatch then
	begin
		AddMessage('Loading NOTE patch');
		LoadRecords('NOTE');
	end;

	if weaponPatch then
	begin
		AddMessage('Loading WEAPON patch');
		LoadRecords('WEAP');
	end
	else if grenadePatch then
	begin
	AddMessage('Loading GRENADE patch');
	LoadRecords('WEAP');
	end;
	
	for i := MaxRecordIndex downto 0 do //Remove WEAPON records if grenadePatch is true
	begin
		rec := GetRecord(i);
		signature := genv(rec, 'Record Header\Signature');
		
		if grenadePatch and (signature = 'WEAP') then
		begin
			rec := GetRecord(i);
			anim := IntToStr(genv(rec, 'DNAM - Data/Animation Type'));
			if (HasKeyword(rec, 'WeaponTypeGrenade')
			or HasKeyword(rec, 'WeaponTypeMine')
			or HasKeyword(rec, 'WeaponTypePlasmaGrenade')
			or HasKeyword(rec, 'WeaponTypeNukaGrenade')
			or HasKeyword(rec, 'WeaponTypeCryoGrenade')
			or HasKeyword(rec, 'WeaponTypePulseGrenade')
			or HasKeyword(rec, 'WeaponTypeBottlecapMine')
			or HasKeyword(rec, 'WeaponTypeNukaMine')
			or HasKeyword(rec, 'WeaponTypePlasmaMine')
			or HasKeyword(rec, 'WeaponTypePulseMine')
			or HasKeyword(rec, 'WeaponTypeCryoMine')) and ((anim = 10) or (anim = 11)) then
			begin
				AddMessage('Found greande/mine WEAPON record: ' + genv(rec, 'EDID - Editor ID'));
			end
			else
			begin
				RemoveRecord(i);
				AddMessage('Removed non greande/mine WEAPON record: ' + genv(rec, 'EDID - Editor ID'));
			end;
		end;
	end;
	
	CopyRecordsToPatch;
	AddMessage('Beginning Patching');
	
	for i := 0 to MaxPatchRecordIndex do
	begin
		rec := GetPatchRecord(i);
		signature := genv(rec, 'Record Header\Signature');
		
		try
			if alchPatch and (signature = 'ALCH') then
			begin
				originalWeight := genv(rec, 'DATA - Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DATA - Weight', newWeight);
					AddMessage('Patched ALCHEMY record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;

			if ammoPatch and (signature = 'AMMO') then
			begin
				originalWeight := genv(rec, 'DATA - Data/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DATA - Data/Weight', newWeight);
					AddMessage('Patched AMMO record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;
			
			if armorPatch and (signature = 'ARMO') then
			begin
				originalWeight := genv(rec, 'DATA - DATA/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DATA - DATA/Weight', newWeight);
					AddMessage('Patched ARMOR record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;

			if bookPatch and (signature = 'BOOK') then
			begin
				originalWeight := genv(rec, 'DATA - Data/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DATA - Data/Weight', newWeight);
					AddMessage('Patched BOOK record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;

			if miscPatch and (signature = 'MISC') then
			begin
				originalWeight := genv(rec, 'DATA - Data/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DATA - Data/Weight', newWeight);
					AddMessage('Patched MISC record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;

			if keymPatch and (signature = 'KEYM') then
			begin
				originalWeight := genv(rec, 'DATA - DATA/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DATA - DATA/Weight', newWeight);
					AddMessage('Patched KEYM record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;
			
			if notePatch and (signature = 'NOTE') then
			begin
				originalWeight := genv(rec, 'DATA - DATA/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DATA - DATA/Weight', newWeight);
					AddMessage('Patched NOTE record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;
			
			if ((weaponPatch or grenadePatch) and (signature = 'WEAP')) then
			begin
				originalWeight := genv(rec, 'DNAM - Data/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DNAM - Data/Weight', newWeight);
					if(grenadePatch) then
					begin
						AddMessage('Patched GRENADE record: ' + genv(rec, 'EDID - Editor ID'));
					end
					else
						AddMessage('Patched WEAPON record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;
			
		except
			on E: Exception do
			AddMessage('Error patching record: ' + genv(rec, 'EDID - Editor ID') + '. ' + E.Message);
		end;
	end;
	
  PrintMXPFReport;
  FinalizeMXPF;
end;

function StringToBool(s: string): Boolean;
begin
	Result := (LowerCase(s) = 'true');
end;

end.