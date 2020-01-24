import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { CustomerProfile } from '../models/customer-profile.model';
import { HttpClient } from '@angular/common/http';
import { catchError, map } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  private _apiUrl = environment.apiUrl;

  constructor(private http: HttpClient) { }

  // Post edit customerProfile
  updateCustomer(_customerProfile: CustomerProfile) {
    // TODO videti da li mozda da backend vrati neku potvrdu
    localStorage.setItem('customer', JSON.stringify(_customerProfile));
    return this.http.post<boolean>(`${this._apiUrl}/profile/edit`, _customerProfile)
      .pipe(map(value => {
        return value;
      }));
  }

  // get Customer
  getCustomer() {
    let customer = localStorage.get("customer");
    return JSON.parse(customer);
  }
}