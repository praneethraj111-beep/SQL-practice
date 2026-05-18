#1. Strings (Text data) - Always wrapped in quotes
project_name = "PulsePoint Healthcare"
manager_name = 'Manish'

#2. Integers (Whole numbers)
total_patients = 5

#3. Floats (Decimal numbers)
total_billing = 30500.50

#4. Booleans (True/False decisions)
pipeline_success = True

# 5. Basic math
average_bill_per_patient = total_billing / total_patients
# CHANGE THIS LINE TO ADD A LABEL:
print(f"Average Bill per Patient: {average_bill_per_patient}")

# 6. The Type Trap
print(f"Project: {project_name} | Total Patients: {total_patients}")

# 7. Lists and Decision Making (Control Flow)
# A list of patient billing amounts (Data Collection)
patient_bills = [1200.50, 4500.00, 8500.25, 9500.00]

print("\n--- PATIENT BILLING AUDIT")

# Loop through each bill in our list
for bill in patient_bills:
    # Decision Making: Check if the bill exceeds a premium threshold
    if bill > 5000.00:
        print(f"Alert: High-Value Account detected! Bill: ${bill}")
    else:
        print(f"Normal Account. Bill: ${bill}")

       # Line 36: The loop starts here
for bill in patient_bills:
    # Line 38: Pushed right by 4 spaces (1 Tab)
    if bill > 7000.00:
        # Line 39: Pushed right by 8 spaces (2 Tabs) because it belongs to 'if'
        print(f"Alert: High-Value Account! Bill: ${bill}")
    # Line 40: Aligned exactly with the 'if' statement
    elif bill > 4000.00:
        # Line 41: Pushed right by 8 spaces
        print(f"Warning: Medium-Value Account. Bill: ${bill}")
    # Line 42: Aligned exactly with 'if' and 'elif'
    else:
        # Line 43: Pushed right by 8 spaces
        print(f"Normal Account. Bill: ${bill}")