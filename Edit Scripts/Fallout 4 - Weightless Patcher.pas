(*
	Author: haloTT100
	Based on Predence's script (https://www.nexusmods.com/skyrimspecialedition/mods/749)
	Credits to him
*)
unit UserScript;

uses 'lib\mxpf';

var
	i: integer;
  	signature : String;
	originalWeight, newWeight: real;
	rec: IInterface;
	alchPatch, ammoPatch, armorPatch, bookPatch, miscPatch, keymPatch, notePatch, weaponPatch : boolean;
	
function Initialize: Integer;
	begin
	
	DefaultOptionsMXPF;
	InitializeMXPF;
	
	
	
	//Change these settings
	alchPatch := true;
	ammoPatch := true;
	armorPatch := true;
	bookPatch := true;
	miscPatch := true;
	keymPatch := true;
	notePatch := true;
	weaponPatch := true;
	//Change these settings
	
	
	
	
	
	
	
	
	
	
	PatchFileByName('WeightLess.esp');
	if(alchPatch) then
	begin
		AddMessage('Loading ALCHEMY patch');
		LoadRecords('ALCH');
	end;
	
	if(ammoPatch) then
	begin
		AddMessage('Loading AMMO patch');
		LoadRecords('AMMO');
	end;
	
	if(armorPatch) then
	begin
		AddMessage('Loading ARMOR patch');
		LoadRecords('ARMO');
	end;
	
	if(bookPatch) then
	begin
		AddMessage('Loading BOOK patch');
		LoadRecords('BOOK');
	end;
	
	if(miscPatch) then
	begin
		AddMessage('Loading MISC patch');
		LoadRecords('MISC');
	end;
	
	if(keymPatch) then
	begin
		AddMessage('Loading KEYM patch');
		LoadRecords('KEYM');
	end;
	
	if(notePatch) then
	begin
		AddMessage('Loading NOTE patch');
		LoadRecords('NOTE');
	end;
	
	if(weaponPatch) then
	begin
		AddMessage('Loading WEAPON patch');
		LoadRecords('WEAP');
	end;
	
	CopyRecordsToPatch;
	AddMessage('Beginning Patching');
	
	for i := 0 to MaxPatchRecordIndex do begin
		rec := GetPatchRecord(i);
		signature := genv(rec, 'Record Header\Signature');
		try

			if(alchPatch) then
			begin
				if(signature = 'ALCH' ) then
				begin
					originalWeight := genv(rec, 'DATA - Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DATA - Weight', newWeight);
							end;
				end;
			end;

			if(ammoPatch) then
			begin
				if(signature = 'AMMO') then
				begin
					originalWeight := genv(rec, 'DATA - Data/Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DATA - Data/Weight', newWeight);
							end;
				end;
			end;
			
			if(bookPatch) then
			begin
				if(signature = 'ARMO') then
				begin
					originalWeight := genv(rec, 'DATA - /Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DATA - /Weight', newWeight);
							end;
				end;
			end;

			if(bookPatch) then
			begin
				if(signature = 'BOOK') then
				begin
					originalWeight := genv(rec, 'DATA - Data/Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DATA - Data/Weight', newWeight);
							end;
				end;
			end;

			if(miscPatch) then
			begin
				if(signature = 'MISC') then 
				begin
					originalWeight := genv(rec, 'DATA - Data/Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DATA - Data/Weight', newWeight);
							end;
				end;
			end;

			if(keymPatch) then
			begin
				if(signature = 'KEYM') then 
				begin
					originalWeight := genv(rec, 'DATA - /Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DATA - /Weight', newWeight);
							end;
				end;
			end;
			
			if(notePatch) then
			begin
				if(signature = 'NOTE') then
				begin
					originalWeight := genv(rec, 'DATA - /Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DATA - /Weight', newWeight);
							end;
				end;
			end;
			
			if(weaponPatch) then
			begin
				if(signature = 'WEAP') then
				begin
					originalWeight := genv(rec, 'DNAM - Data/Weight');
					newWeight := 0;

					if(originalWeight = newWeight) 
						then
							begin
							removeNode(rec);
							end
						else
							begin
							seev(rec, 'DNAM - Data/Weight', newWeight);
							end;
				end;
			end;
		except
			AddMessage('Failed to parse item!');
			continue;
		end;
	end;
  
  PrintMXPFReport;
  FinalizeMXPF;
end;
end.