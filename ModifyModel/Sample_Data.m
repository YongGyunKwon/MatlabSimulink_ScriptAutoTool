
%Sample Data
Type_Modify={"MOD", "ADD", "DEL"};
Scope=["Input","Output","Parameter","Local"];

EditSignal(1).Type="MOD";
EditSignal(1).Scope="Input";
EditSignal(1).Origin_Data="Input_BBB";
EditSignal(1).Modify_Data="Input_ThisisInput";

EditSignal(2).Type="DEL";
EditSignal(2).Scope="Input";
EditSignal(2).Origin_Data="Input_CCC";

EditSignal(3).Type="ADD";
EditSignal(3).Scope="Input";
%EditSignal(3).Origin_Data="Input_";
EditSignal(3).Modify_Data="Input_ThisisNew";

EditSignal(4).Type="MOD";
EditSignal(4).Scope="Local";
EditSignal(4).Origin_Data="b_Running";
EditSignal(4).Modify_Data="b_ModifyRunning";

EditSignal(4).Type="ADD";
EditSignal(4).Scope="Output";
%EditSignal(4).Origin_Data="b_Running";
EditSignal(4).Modify_Data="Output_HelloOutput";

EditSignal(5).Type="MOD";
EditSignal(5).Scope="Output";
EditSignal(5).Origin_Data="Output_BBB";
EditSignal(5).Modify_Data="Output_OutModify";


EditSignal(6).Type="MOD";
EditSignal(6).Scope="Local";
EditSignal(6).Origin_Data="Four_bb";
EditSignal(6).Modify_Data="Four_cc";