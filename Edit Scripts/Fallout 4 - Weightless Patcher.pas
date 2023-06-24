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
  alchPatch, ammoPatch, armorPatch, bookPatch, miscPatch, keymPatch, notePatch, weaponPatch, grenadePatch: String;
	
function Initialize: Integer;
begin
	DefaultOptionsMXPF;
	InitializeMXPF;
	
	InputQuery('Do you want to make foods/ingredients weightless?', 'Input true or false:', alchPatch);
	InputQuery('Do you want to make ammunitions weightless?', 'Input true or false:', ammoPatch);
	InputQuery('Do you want to make armors weightless?', 'Input true or false:', armorPatch);
	InputQuery('Do you want to make books weightless?', 'Input true or false:', bookPatch);
	InputQuery('Do you want to make miscellaneous items weightless?', 'Input true or false:', miscPatch);
	InputQuery('Do you want to make keys weightless?', 'Input true or false:', keymPatch);
	InputQuery('Do you want to make notes weightless?', 'Input true or false:', notePatch);
	InputQuery('Do you want to make weapons weightless?', 'Input true or false:', weaponPatch);
	if(not StringToBool(weaponPatch)) then
		InputQuery('Do you want to make grenades weightless?', 'Input true or false:', grenadePatch);
	
	PatchFileByName('WeightLess.esp');

	if StringToBool(alchPatch) then
	begin
		AddMessage('Loading ALCHEMY patch');
		LoadRecords('ALCH');
	end;

	if StringToBool(ammoPatch) then
	begin
		AddMessage('Loading AMMO patch');
		LoadRecords('AMMO');
	end;

	if StringToBool(armorPatch) then
	begin
		AddMessage('Loading ARMOR patch');
		LoadRecords('ARMO');
	end;

	if StringToBool(bookPatch) then
	begin
		AddMessage('Loading BOOK patch');
		LoadRecords('BOOK');
	end;

	if StringToBool(miscPatch) then
	begin
		AddMessage('Loading MISC patch');
		LoadRecords('MISC');
	end;

	if StringToBool(keymPatch) then
	begin
		AddMessage('Loading KEYM patch');
		LoadRecords('KEYM');
	end;

	if StringToBool(notePatch) then
	begin
		AddMessage('Loading NOTE patch');
		LoadRecords('NOTE');
	end;

	if StringToBool(weaponPatch) then
	begin
		AddMessage('Loading WEAPON patch');
		LoadRecords('WEAP');
	end;
	
	if StringToBool(grenadePatch) then
	begin
		AddMessage('Loading GRENADE patch');
		LoadRecords('WEAP');
	end;
	
	CopyRecordsToPatch;
	AddMessage('Beginning Patching');
	
	for i := 0 to MaxPatchRecordIndex do
	begin
		rec := GetPatchRecord(i);
		signature := genv(rec, 'Record Header\Signature');
		
		try
			if StringToBool(alchPatch) and (signature = 'ALCH') then
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

			if StringToBool(ammoPatch) and (signature = 'AMMO') then
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
			
			if StringToBool(armorPatch) and (signature = 'ARMO') then
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

			if StringToBool(bookPatch) and (signature = 'BOOK') then
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

			if StringToBool(miscPatch) and (signature = 'MISC') then
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

			if StringToBool(keymPatch) and (signature = 'KEYM') then
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
			
			if StringToBool(notePatch) and (signature = 'NOTE') then
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
			
			if StringToBool(weaponPatch) and (signature = 'WEAP') then
			begin
				originalWeight := genv(rec, 'DNAM - Data/Weight');
				newWeight := 0;

				if originalWeight <> newWeight then
				begin
					seev(rec, 'DNAM - Data/Weight', newWeight);
					AddMessage('Patched WEAPON record: ' + genv(rec, 'EDID - Editor ID'));
				end
				else
					removeNode(rec);
			end;
			
			if StringToBool(grenadePatch) and (signature = 'WEAP') then
			begin
				anim := genv(rec, 'DNAM - Data/Animation Type');
				if (anim = 10) or (anim = 11) then
				begin
					originalWeight := genv(rec, 'DNAM - Data/Weight');
					newWeight := 0;

					if originalWeight <> newWeight then
					begin
						seev(rec, 'DNAM - Data/Weight', newWeight);
						AddMessage('Patched GRENADE record: ' + genv(rec, 'EDID - Editor ID'));
					end
					else
						removeNode(rec);
				end;
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
  s := LowerCase(s);
  Result := (s = 'true');
end;
end.