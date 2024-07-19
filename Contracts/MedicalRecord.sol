// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract MedicalRecord {
    //admin of contract address
    address admin;

    //constructor
    constructor() {
        admin = msg.sender;
    }

    //structure of doctor
    struct Doctor {
        uint id;
        string name;
        string qualification;
        string clinicAddress;
    }

    //structure of patient
    struct Patient {
        uint id;
        string name;
        uint age;
        string gender;
    }

    //structure of medicine
    struct Medicine {
        uint id;
        string name;
        string expiryDate;
        string dose;
        string price;
    }

    //structure of disease
    struct Disease {
        string name;
    }

    //count of doctors and also the id of doctors
    uint doctorCount = 0;

    //count of patients and also the id of patients
    uint patientCount = 0;

    //array of doctor's account address
    address[] doctorAddress;

    //array of patient's account address
    address[] patientAddress;

    //array to store the medicine's Id
    uint[] medicineId;

    //mapping to connect doctorId to doctor
    mapping (uint => Doctor) doctors;

    //mapping to connect patientId to patient
    mapping (uint => Patient) patients;

    //mapping to connect medicine id to medicine
    mapping (uint => Medicine) medicines;

    //mapping to connect patient address to an array of medicines, since one can have multiple diseases
    mapping (address => Medicine[]) prescribedMedicines;

    //mapping to connet patient to their diseases
    mapping (uint => Disease[]) patientDisease;

    //modifier to check for only admin access
    modifier onlyAdmin {
        require(admin == msg.sender, "you are not the admin to make this transaction.");
        _;
    }

    //modifier to check only doctor
    modifier onlyDoctor {
        require(isDoctor(msg.sender), "you are not the doctor to make this transaction.");
        _;
    }

    //modifier to check only patient
    modifier onlyPatient {
        require(isPatient(msg.sender), "you are not the patient to make this transaction.");
        _;
    }

    //helper function to check if a person is a doctor
    function isDoctor(address _doctorAddress) private view returns (bool) {
        for (uint i = 0; i<doctorAddress.length; i++) {
            if (doctorAddress[i] == _doctorAddress) return true;
        }
        return false;
    }

    //helper function to check if a person is a patient
    function isPatient(address _patientAddress) private view returns (bool) {
        for (uint i = 0; i<patientAddress.length; i++) {
            if (patientAddress[i] == _patientAddress) return true;
        }
        return false;        
    }

    //helper function to check if the medicine with same id already exists
    function checkMedicine(uint _id) private view returns (bool) {
        for (uint i = 0; i<medicineId.length; i++) {
            if (medicineId[i] == _id) return false;
        }
        return true;         
    }

    //function to add new doctor
    function registerDoctor(string memory _name, string memory _qualification, string memory _clinicAddress,  address _doctorAddress) onlyAdmin public {
        doctors[doctorCount] = Doctor(++doctorCount, _name, _qualification, _clinicAddress);
        doctorAddress.push(_doctorAddress);
    } 

    //function to add new patient
    function registerPatient(string memory _name, uint _age, string memory _gender, address _patientAddress) onlyAdmin public {
        patients[patientCount] = Patient(++patientCount, _name, _age, _gender);
        patientAddress.push(_patientAddress);
    }

    //function to add medicine
    function addMedicine(uint _id, string memory _name, string memory _expityDate, string memory _dose, string memory _price) onlyAdmin public {
        //medicine can only be added if it is not already present
        require(checkMedicine(_id), "Medicine with same Id already exist, hence cannot be added");
        medicines[_id] = Medicine(_id, _name, _expityDate, _dose, _price);
    }

    //function to add new disease
    function addNewDisease(uint _patientId, string memory _disease) onlyDoctor public {
        Disease memory newDisease = Disease({
            name : _disease
        });

        patientDisease[_patientId].push(newDisease);
    }

    //function to prescribe medicine to a patient
    function prescribeMedicine(address _patientAddress, uint _medicineId) onlyDoctor public {
        //a patient can have multiple diseases hence multiple medicines can be prescribed based on that.
        Medicine memory _prescribedMedicine = Medicine({
            id : _medicineId,
            name : medicines[_medicineId].name,
            expiryDate : medicines[_medicineId].expiryDate,
            dose : medicines[_medicineId].dose,
            price : medicines[_medicineId].price
        });

        prescribedMedicines[_patientAddress].push(_prescribedMedicine);
    }

    //function to update age of patient
    function updateAge(uint _patientId, uint _updatedAge) onlyPatient public {
        patients[_patientId].age = _updatedAge;
    }

    //function to view patient data
    function viewRecord(uint _id) onlyPatient public view returns (uint _patientId, string memory _patientName, uint _patientAge, string memory _gender, Disease[] memory _patientDisease) {
        return (patients[_id].id, patients[_id].name, patients[_id].age, patients[_id].gender, patientDisease[_id]);
    }

    //function to view medicine details
    function viewMedicine(uint _id) public view returns (string memory _medicineName, string memory _medicineExpiryDate, string memory _medicineDoses, string memory _price) {
        return (medicines[_id].name, medicines[_id].expiryDate, medicines[_id].dose, medicines[_id].price);
    }

    //function to view presribed medicine
    function viewPrescribedMedicine(address _patientAddress) onlyPatient public view returns (Medicine[] memory _presecribedMedicines) {
        //show the prescribed medicine details
        return prescribedMedicines[_patientAddress];
    }

    //function to view patient's details by doctor
    function viewPatientByDoctor(uint _id) onlyDoctor public view returns (uint _patientId, string memory _patientName, uint _patientAge, string memory _patientGender, Disease[] memory _patientDisease) {
        return (patients[_id].id, patients[_id].name, patients[_id].age, patients[_id].gender, patientDisease[_id]);
    }

    //function to view doctor's details
    function viewDoctorById(uint _id) public view returns (uint _doctorId, string memory _name, string memory _qualification, string memory _clinicAddress) {
        return (doctors[_id].id, doctors[_id].name, doctors[_id].qualification, doctors[_id].clinicAddress);
    }
}