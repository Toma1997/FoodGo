import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { Router } from '@angular/router';
import { CustomerService } from 'src/app/services/customer.service';
import { ErrorHelper } from 'src/app/utilities/ErrorHelper';
import { ProfileAddressList } from 'src/app/models/profile-address-list.model';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-address',
  templateUrl: './address.component.html',
  styleUrls: ['./address.component.sass']
})
export class AddressComponent implements OnInit {
  @ViewChild('closeAddressModal', { static: true }) closeAddressModal: ElementRef;
  addresses: Array<string>;
  addressPattern = "^([A-z]+\\s)+([1-9]|[1-9][0-9]{1,2})[a-z]{0,1}$";
  addressForm: FormGroup;
  submitted = false;
  hide = true;
  error: any;
  total: Array<number>;
  current: number;
  limit = 5; 
  constructor(private router: Router, private _customerService: CustomerService, private formBuilder: FormBuilder) { }

  ngOnInit() {
    this._fetchCustomerAddresses(10);
    this.addressForm = this.formBuilder.group({
      address: ['', Validators.required],
    });
  }

  private _fetchCustomerAddresses(limit: number = 1) {
    this._customerService.getCustomerAddresses(limit).toPromise()
      .then(response => { this.addresses = response.addresses; this.total = Array(Math.ceil(response.addresses.length / this.limit)); this.current = 1; })
      .catch(error => this.error = ErrorHelper.generateErrorObj(error));
  }

  private updateAddresses(index: number) {
    //var index = this.addresses.findIndex(address => address == removeAddress);
    this.addresses.splice(index, 1);
    var updateAddresses = new ProfileAddressList();
    updateAddresses.addresses = this.addresses;
    this._customerService.updateCustomerAddresses(updateAddresses);
    this.total = Array(Math.ceil(this.addresses.length / this.limit));
    if (index>this.total.length){
      this.current = this.current-1;
    }
  }

  public showAddresses(): boolean {
    return this.addresses != undefined && this.addresses.length != 0;
  }

  // convenience getter for easy access to form fields
  get f() { return this.addressForm.controls; }

  addAddress() {
    this.submitted = true;
    // stop here if form is invalid
    if (this.addressForm.invalid) {
      return;
    }
    this.addresses.push(this.f.address.value);
    this.total = Array(Math.ceil(this.addresses.length / this.limit));
    var updateAddresses = new ProfileAddressList();
    updateAddresses.addresses = this.addresses;
    this._customerService.updateCustomerAddresses(updateAddresses);
    this.addressForm.reset();
    this.submitted = false;
    this.closeAddressModal.nativeElement.click();
  }

  public receiveCurrentPage($event) {
    this.current = $event;
    console.log($event);
  }

  public getPageLimit(id: number) {
    return (((this.current - 1) * this.limit) <= id) && (id < (this.current * this.limit));
  }
}
